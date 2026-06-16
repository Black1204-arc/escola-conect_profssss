@echo off
REM Escolaconnect Development Helper

if "%1"=="help" (
    echo.
    echo EscolaConnect - Commands:
    echo.
    echo   dev          - Start with docker-compose watch (hot-reload)
    echo   up           - Start in background
    echo   down         - Stop all services
    echo   logs         - See all logs
    echo   logs-backend - See backend logs
    echo   logs-frontend- See frontend logs
    echo   logs-mongo   - See MongoDB logs
    echo   bash         - Access backend bash shell
    echo   shell        - Access frontend shell
    echo   clean        - Remove containers and volumes
    echo   help         - Show this help
    echo.
    goto :eof
)

if "%1"=="dev" (
    docker-compose watch
    goto :eof
)

if "%1"=="up" (
    docker-compose up -d
    echo.
    echo ✅ Containers started!
    echo.
    echo 📱 Frontend:  http://localhost:3000
    echo 🔌 Backend:   http://localhost:8001
    echo 🗄️  MongoDB:   localhost:27017
    echo.
    goto :eof
)

if "%1"=="down" (
    docker-compose down
    goto :eof
)

if "%1"=="logs" (
    docker-compose logs -f
    goto :eof
)

if "%1"=="logs-backend" (
    docker-compose logs -f backend
    goto :eof
)

if "%1"=="logs-frontend" (
    docker-compose logs -f frontend
    goto :eof
)

if "%1"=="logs-mongo" (
    docker-compose logs -f mongodb
    goto :eof
)

if "%1"=="bash" (
    docker exec -it escolaconnect-backend bash
    goto :eof
)

if "%1"=="shell" (
    docker exec -it escolaconnect-frontend sh
    goto :eof
)

if "%1"=="clean" (
    docker-compose down -v
    echo ✅ Cleaned up!
    goto :eof
)

echo Usage: .\dev.bat [command]
echo.
echo Run '.\dev.bat help' for more information.
