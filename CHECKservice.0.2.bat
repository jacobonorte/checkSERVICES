@ECHO OFF

	:start
		CALL :checkSERVICE
		SET choice=
		SET /p choice="Do you want to check another service? Press 'y' and enter for Yes: "
		if not '%choice%'=='' set choice=%choice:~0,1%
		if '%choice%'=='y' goto start

		:checkSERVICE
			SET /p ID="Enter Service here: "
			SET checkSERVICENAME=%ID%

			SC QUERYEX "%checkSERVICENAME%" | FIND "STATE" | FIND /v "RUNNING" > NUL && (
				ECHO %checkSERVICENAME% is not running
				ECHO starting %checkSERVICENAME%
				net start "%checkSERVICENAME%" > NUL || (
					ECHO "%checkSERVICENAME%" will not start
					TIMEOUT /t 3
					PAUSE
				)
				ECHO %checkSERVICENAME% is started.
			)
			IF %ERRORLEVEL% NEQ 0 ECHO %checkSERVICENAME% is running
			TIMEOUT /t 2

			SC QUERYEX "%checkSERVICENAME%" | FIND "STATE" | FIND /v "RUNNING" > NUL && (
				ECHO %checkSERVICENAME% is not running || (
					TIMEOUT /t 2
					ECHO "%checkSERVICENAME%" will not start
					TIMEOUT /t 2
					PAUSE
				)
			)
			IF %ERRORLEVEL% NEQ 0 ECHO %checkSERVICENAME% is running fine
			TIMEOUT /t 2

			SC QUERYEX "%checkSERVICENAME%" | FIND "STATE" | FIND /v "STOPPED" > NUL && (
				net stop "%checkSERVICENAME%" > NUL & (
					ECHO %checkSERVICENAME% is stopped
					TIMEOUT /t 1
				)
			)

			SC QUERYEX "%checkSERVICENAME%" | FIND "STATE" | FIND /v "STOPPED" < NUL && (
				ECHO %checkSERVICENAME% will not stop
			)

			ECHO verified that %checkSERVICENAME% is not running
			TIMEOUT /t 4
			EXIT /b 0
