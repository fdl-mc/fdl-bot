from cogs.listeners import Listeners
from cogs.passport import Passport
from cogs.monitoring import Monitoring
from discord.ext.commands import Bot

bot = Bot(command_prefix='f!')


@bot.event
async def on_ready():
    print('Bot started')

    bot.add_cog(Monitoring(bot))
    bot.add_cog(Passport(bot))
    bot.add_cog(Listeners(bot))

bot.run('кокен')
