import discord
from discord.ext import commands


class Listeners(commands.Cog):
    def __init__(self, bot):
        self.bot = bot
        print('Listeners cog has been loaded')

    @commands.Cog.listener()
    async def on_command_error(self, ctx, error):
        if isinstance(error, commands.CommandNotFound):
            return

        if isinstance(error, commands.NotOwner):
            return await ctx.send('это не для тебя, мой хороший')

        if isinstance(error, commands.MissingRequiredArgument):
            return await ctx.send('дебил блять')

        await ctx.send(f'ты чево наделал.......\n```\n{str(error)}\n```')
