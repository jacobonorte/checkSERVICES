@ECHO OFF

set /p id="Enter Service: "

SET nameServer=%id%
	SC QUERYEX FIND "ALL" | FIND "STATE" | FIND /v "RUNNING" > NUL && (
		ECHO %nameServer% is not running > NUL
		
		ECHO starting %nameServer% > NUL
		net start "%nameServer%" > NUL || (
			ECHO "%nameServer%" will not start
			TIMEOUT /t 1 > NUL
			exit /b 1 
			)
		ECHO %nameServer% is started > NUL
		)
		IF %ERRORLEVEL% NEQ 0 Echo %nameServer% is running > NUL
		TIMEOUT /t 2 > NUL

	SC QUERYEX "%nameServer%" | FIND "STATE" | FIND /v "RUNNING" > NUL && (
		ECHO %nameServer% is not running > NUL || (
			TIMEOUT /t 1 > NUL
			ECHO "%nameServer%" will not start
			TIMEOUT /t 2 > NUL
			PAUSE
			)
		)
		IF %ERRORLEVEL% NEQ 0 Echo %nameServer% is running fine > NUL
		TIMEOUT /t 1 > NUL
	
	SC QUERYEX "%nameServer%" | FIND "STATE" | FIND /v "STOPPED" > NUL && (
		net stop "%nameServer%" > NUL & (
			ECHO %nameServer% is stopped > NUL
			TIMEOUT /t 1 > NUL
			)
		)
	
	SC QUERYEX "%nameServer%" | FIND "STATE" | FIND /v "STOPPED" < NUL && (
		ECHO %nameServer% will not stop > NUL
		)
		ECHO verified that %nameServer% is not running > NUL
		PAUSE
		
		


			
		


	

	
	
	
	
	
		
	