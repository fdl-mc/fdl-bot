import discord
from discord.ext import commands

from firebase_admin import credentials
from firebase_admin import initialize_app
from firebase_admin import firestore
from firebase_admin import auth

import string
import random


class Passport(commands.Cog):
    @staticmethod
    def generate_password():
        return ''.join(random.choices(string.ascii_lowercase + string.digits, k=6))

    def __init__(self, bot):
        self.bot = bot
        self.fb = initialize_app(
            credential=credentials.Certificate('./admin.json'))
        self.auth = auth
        self.db = firestore.client(app=self.fb)

        print('Passport cog has been loaded')

    @commands.is_owner()
    @commands.command()
    async def add_user(self, ctx: commands.Context, user: discord.User, nickname: str):
        password = Passport.generate_password()
        fb_user: auth.User = self.auth.create_user(email=nickname + '@fdl.ru',
                                                   password=password)

        await ctx.send('Пользователь создан, добавляем запись в датабазе...')

        self.db.collection(u'users').document(
            fb_user.uid).set({'name': nickname,
                              'balance': 0,
                              'discord_id': str(user.id),
                              'admin': False,
                              'judge': False})

        await ctx.send('Вроде добавлено, ща в личку ему данные от акка скину...')
        await user.send(
            f'Ваш паспорт FDL был успешно зарегистрирован.\nЛогин: `{nickname}`\nПароль: `{password}`\n\nP.S. пароль Вы сможете поменять в любое время через приложение.')
        await ctx.send('готово ёпта')
