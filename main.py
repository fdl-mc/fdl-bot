from discord.ext.commands import Bot
from discord.ext.tasks import loop
from mcstatus import MinecraftServer

IP = 'play.fdl-mc.ru'
PORT = 25565
GUILD_ID = 705281809726046212
CHANNEL_ONLINE_ID = 733568472163811348
CHANNEL_PING_ID = 825926055620771890
CHANNEL_STATE_ID = 825931028106838016

bot = Bot(command_prefix='f!')
server = MinecraftServer(IP, PORT)


@bot.event
async def on_ready():
    print('Bot started')


@loop(seconds=30)
async def update_ping():
    await bot.wait_until_ready()

    ch_ping = bot.get_channel(CHANNEL_PING_ID)

    try:
        ping = int(server.ping())
        # ping -= ping % 10
    except Exception as e:
        await ch_ping.edit(name=f'Пинг: N/A')
    else:
        await ch_ping.edit(name=f'Пинг: ~{ping} мс')

    print('Updated ping')


@loop(seconds=30)
async def update_online():
    await bot.wait_until_ready()

    ch_online = bot.get_channel(CHANNEL_ONLINE_ID)
    try:
        server_info = server.query()
        print(server_info.players.online)
    except:
        await ch_online.edit(name='Онлайн: N/A')
    else:
        players_max = server_info.players.max
        players_online = server_info.players.online

        await ch_online.edit(name='Онлайн: {}/{}'.format(players_online, players_max))

    print('Updated online')


@loop(seconds=30)
async def update_state():
    await bot.wait_until_ready()

    ch_state = bot.get_channel(CHANNEL_STATE_ID)
    try:
        server.query()
    except:
        await ch_state.edit(name='Состояние: Офлайн')
    else:
        await ch_state.edit(name='Состояние: Онлайн')

    print('Updated state')

update_ping.start()
update_online.start()
update_state.start()

bot.run('пососи у у у  у у да я богаетый уебок токена не будет кароч =(')
