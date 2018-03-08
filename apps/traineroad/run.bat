
REM comment out the next line if don't want to redownload,
REM dont blow away metadata table

python .\DownloadTrainerRoadTcx.py
python .\tcxParser.py
python .\TcxAnalyzer.py
