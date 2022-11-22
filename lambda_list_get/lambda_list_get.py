import boto3
import requests
import datetime
import os

client = boto3.client('lambda')
ary_function_name = []
functionDict = {}
    
aliasArray = ["$LATEST", "DEV", "STG"]

def function_list(max_items=50, next_marker=None):
    if next_marker:
        r = client.list_functions(MaxItems=max_items, Marker=next_marker)
    else:
        r = client.list_functions(MaxItems=max_items)
    
    for functions in r['Functions']:
        functionDict[functions['FunctionName']] = functions['FunctionArn']
        ary_function_name.append(functions['FunctionName'])

    if 'NextMarker' in r:
        return function_list(max_items=max_items, next_marker=r['NextMarker'])
    else:
        return

def lambda_handler(event, context):
    print("### start")
    r = function_list()
    # print(functionDict)

    # 出力先（output/{システム時刻}/{エイリアス名}
    outputBaseDir = "output/"+ datetime.datetime.now().strftime('%Y%m%d_%H%M%S')
    for alias in aliasArray:
        os.makedirs(outputBaseDir  + "/" + alias)

    for k,v in functionDict.items():
        for alias in aliasArray:
            filename =  outputBaseDir  + "/" + alias + "/" + k + ".zip"
            try:
                func = client.get_function(FunctionName=k, Qualifier=alias)

                # コード取得用のURL取得
                codeLocation = func["Code"]["Location"]

                # httpリクエスト
                response = requests.get(codeLocation)

                # 保存
                writeFile(filename, response)
            except Exception as ex:
                # エイリアス名が無いものは無視
                pass
        
    print("### end")
    return

def writeFile(filename, response):

    # with open(filename ,mode='wb') as f: # wb でバイト型を書き込める
    #     f.write(data)
    #open()関数にwbを渡し、バイナリ書き込みモードで新規ファイル生成
    file = open(filename,"wb")

    #各チャンクをwrite()関数でローカルファイルに書き込む
    for chunk in response.iter_content(100000):
        file.write(chunk)

    #ファイルを閉じる
    file.close()
    print("ダウンロード・ファイル保存完了", filename)
if __name__ == '__main__':
	lambda_handler(None, None)