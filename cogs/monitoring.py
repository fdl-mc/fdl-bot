import discord
from discord.ext import commands
from discord.ext.tasks import loop
from mcstatus.server import MinecraftServer


class Monitoring(commands.Cog):
    IP = 'play.fdl-mc.ru'
    PORT = 25565
    GUILD_ID = 705281809726046212
    CHANNEL_ONLINE_ID = 733568472163811348
    CHANNEL_PING_ID = 825926055620771890
    CHANNEL_STATE_ID = 825931028106838016

    def __init__(self, bot):
        self.bot = bot
        self.update_ping.start()
        self.update_online.start()
        self.update_state.start()

        self.server = MinecraftServer(self.IP, self.PORT)
        print('Monitoring cog has been loaded')

    def cog_unload(self):
        self.update_ping.cancel()
        self.update_online.cancel()
        self.update_state.cancel()

    @loop(seconds=30)
    async def update_ping(self):
        await self.bot.wait_until_ready()

        ch_ping = self.bot.get_channel(self.CHANNEL_PING_ID)

        try:
            ping = int(self.server.ping())
            # ping -= ping % 10
        except Exception as e:
            await ch_ping.edit(name=f'Пинг: N/A')
        else:
            await ch_ping.edit(name=f'Пинг: ~{ping} мс')

    @loop(seconds=30)
    async def update_online(self):
        await self.bot.wait_until_ready()

        ch_online = self.bot.get_channel(self.CHANNEL_ONLINE_ID)
        try:
            server_info = self.server.query()
        except:
            await ch_online.edit(name='Онлайн: N/A')
        else:
            players_max = server_info.players.max
            players_online = server_info.players.online

            await ch_online.edit(name='Онлайн: {}/{}'.format(players_online, players_max))

    @loop(seconds=30)
    async def update_state(self):
        await self.bot.wait_until_ready()

        ch_state = self.bot.get_channel(self.CHANNEL_STATE_ID)
        try:
            self.server.query()
        except:
            await ch_state.edit(name='Состояние: Офлайн')
        else:
            await ch_state.edit(name='Состояние: Онлайн')
