import pandas as pd
from matplotlib.pyplot import *
import numpy as np

N = 1000
name = "korona.csv"


class trade:
    __name = ""
    __money = 0

    def __init__(self, name, money):
        self.__name = name
        self.__money = money
        self.trading()

    def trading(self):
        bought = 0

        transactions = 0
        starting_money = self.__money
        macd = Macd(self.__name)
        exchange = data(self.__name)
        exchange, days = exchange.getData()
        signal = macd.getBuySell()
        print(exchange)
        print(signal)
        for i in range(1, len(signal)):
            if signal[i] == int(1) and bought == 0:
                bought = (self.__money) / exchange[i]  # count how many actions are bought
                self.__money = self.__money - (self.__money)
                transactions = transactions + 1
                print("bought for: " + str(exchange[i]))
            elif signal[i] == int(-1) and bought > 0:
                self.__money = self.__money + (bought * exchange[i])  # sell previously bought actions
                transactions = transactions + 1
                print("sold for: " + str(exchange[i]))
                bought = 0

        print("To sold: " + str(bought) + " now for: " + str(exchange[len(signal)]) + " equals: " + str(
            bought * exchange[len(signal)]))
        print("After trading for 1000 days and completing " + str(transactions) + " transactions from: " + str(
            starting_money) + " PLN, we have: " + str(self.__money) + " PLN.")


class data:
    __name = ""

    def __init__(self, name):
        self.__name = name

    def getData(self):
        data = pd.read_csv(self.__name)  # load csv file
        close_data = []
        days_reversed = []
        for i in range(0, N):
            close_data.append(float(data.iloc[i, 2]))  # 2 miałem
            days_reversed.append(data.iloc[i, 1])

        days = []
        data_reversed = []
        for i in reversed(close_data):
            data_reversed.append(i)
        for i in reversed(days_reversed):
            days.append(i)
        return data_reversed, days


class Macd:
    __macd = []
    __signal = []
    __date = []
    __buy_and__sell_signals = []

    def __init__(self, name):
        numbers = data(name)
        numbers, days = numbers.getData()
        self.macd(numbers)
        self.signal()
        self.buySell()
        self.__date = days

    def eman(self, n, data, day):
        alpha = float(2 / (n + 1))
        p_reversed = data[day - n: day:]
        p_base = []

        for i in reversed(p_reversed):
            p_base.append(i)

        counter = float(0.0)
        denominator = float(0.0)

        for i in range(n):
            number = pow(float((1 - alpha)), i)
            counter += p_base[i] * number
            denominator += number

        return counter / denominator

    def signal(self):
        self.__signal = []

        for i in range(1, len(self.__macd)):
            if i < 9:
                ema9 = self.eman(i, self.__macd, i)
                self.__signal.append(0)
            else:
                ema9 = self.eman(9, self.__macd, i)
                self.__signal.append(ema9)

    def macd(self, exchange):
        self.__macd = []
        for i in range(1, len(exchange)):
            if i <= 12:
                ema12 = self.eman(i, exchange, i)
                ema26 = self.eman(i, exchange, i)
                self.__macd.append(ema12 - ema26)
            elif i < 26:
                ema12 = self.eman(12, exchange, i)
                ema26 = self.eman(i, exchange, i)
                self.__macd.append(ema12 - ema26)
            else:
                ema12 = self.eman(12, exchange, i)
                ema26 = self.eman(26, exchange, i)
                self.__macd.append(ema12 - ema26)

    def buySell(self):
        self.__buy_and__sell_signals.clear()
        self.__buy_and__sell_signals.append(int(0))
        minus = 0
        plus = 0
        for var in range(1, len(self.__macd) - 1):
            if self.__macd[var - 1] > self.__signal[var - 1] and self.__macd[var] <= self.__signal[var] and self.__macd[var] > 0:
                minus = minus + 1
                self.__buy_and__sell_signals.append(int(-1))
            elif self.__macd[var - 1] < self.__signal[var - 1] and self.__macd[var] >= self.__signal[var] and self.__macd[var] < 0:
                plus = plus + 1
                self.__buy_and__sell_signals.append(int(1))
            else:
                self.__buy_and__sell_signals.append(int(0))
        print(plus)
        print(minus)

    def getMacd(self):
        return self.__macd

    def getSignal(self):
        return self.__signal

    def getDate(self):
        return self.__date

    def getBuySell(self):
        return self.__buy_and__sell_signals


class Plot:
    def __init__(self, name):
        self.create_macd_plot(name)
        self.create_data_plot(name)
        self.create_macd_and_dara_plot(name)

    def create_macd_plot(self, name):
        numbers = Macd(name)
        titleName = ''
        for i in name:
            if i == '.':
                break
            else:
                titleName += i

        titleName += " MACD Pointer"
        p1, = plot(numbers.getMacd(), label="macd")  # macd blue
        p2, = plot(numbers.getSignal(), label="signal")
        l1 = legend([p1], ["macd"], loc=1)
        l2 = legend([p2], ["signal"], loc=2)
        grid(True)
        days = numbers.getDate()
        xlabel('Days, from: ' + days[0] + ' to ' + days[N - 1])
        ylabel('Values')
        xticks(np.arange(0, N + 1, step=N / 5), (
            days[0], days[int(N / 5)], days[int(2 * N / 5)], days[int(3 * N / 5)], days[int(4 * N / 5)],
            days[int(N - 1)]))
        title(titleName)
        gca().add_artist(l1)
        show()

    def create_data_plot(self, name):
        numbers = data(name)
        titleName = ""
        for i in name:
            if i == '.':
                break
            else:
                titleName += i
        titleName += " exchange"
        numbers, days = numbers.getData()
        plot(numbers)
        grid(True)
        xlabel('Days, from: ' + days[0] + ' to ' + days[N - 1])
        ylabel('Cost in PLN')
        xticks(np.arange(0, N + 1, step=N / 5), (
            days[0], days[int(N / 5)], days[int(2 * N / 5)], days[int(3 * N / 5)], days[int(4 * N / 5)],
            days[int(N - 1)]))
        title(titleName)
        show()

    def create_macd_and_dara_plot(self, name):
        numbers = Macd(name)
        imputData = data(name)
        imputData, days = imputData.getData()
        titleName = ''
        for i in name:
            if i == '.':
                break
            else:
                titleName += i

        p1, = plot(numbers.getMacd(), label="macd")  # macd blue
        p2, = plot(imputData, label="input data")
        l1 = legend([p1], ["macd"], loc=1)
        l2 = legend([p2], ["input data"], loc=2)
        grid(True)
        xlabel('Days, from: ' + days[0] + ' to ' + days[N - 1])
        ylabel('Values')
        xticks(np.arange(0, N + 1, step=N / 5), (
            days[0], days[int(N / 5)], days[int(2 * N / 5)], days[int(3 * N / 5)], days[int(4 * N / 5)],
            days[int(N - 1)]))
        title(titleName)
        gca().add_artist(l1)
        show()


def main():
    # b = Plot(name)
    c = trade(name, 1000)


main()
