import pandas as pd


data = pd.read_excel('raw_data.xlsx', sheet_name='Data')
data.head(10)


results = data.iloc[:, : 6]
dialogs = data.iloc[:, 9: ]


results.rename(columns={
    'дата': 'dt',
    'результат диалога': 'result',
    'тематика': 'subject',
    'группа': 'group_name',
    'оператор': 'operator',
    },
    inplace=True
)

dialogs.rename(columns={
    'dialog_id.1': 'dialog_id',
    'timestamp': 'time_stamp',
    'Кнопка': 'button',
    'Текст': 'msg_text',
    },
    inplace=True
)


results = results.dropna(how='all')
dialogs = dialogs.dropna(how='all')

dialogs['time_stamp'] = dialogs['time_stamp'].astype(int) 
dialogs['ts'] = pd.to_datetime(dialogs['time_stamp'], unit='ms')



results.to_csv('my_db-init/results.csv', sep=';', index=False)
dialogs.to_csv('my_db-init/dialogs.csv', sep=';', index=False)