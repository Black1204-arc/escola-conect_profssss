#!/bin/bash

# EscolaConnect Development Helper

show_help() {
    cat << EOF

EscolaConnect - Commands:

  dev          - Start with docker-compose watch (hot-reload)
  up           - Start in background
  down         - Stop all services
  logs         - See all logs
  logs-backend - See backend logs
  logs-frontend- See frontend logs
  logs-mongo   - See MongoDB logs
  bash         - Access backend bash shell
  shell        - Access frontend shell
  clean        - Remove containers and volumes
  help         - Show this help

EOF
}

case "$1" in
    dev)
        docker-compose watch
        ;;
    up)
        docker-compose up -d
        echo ""
        echo "✅ Containers started!"
        echo ""
        echo "📱 Frontend:  http://localhost:3000"
        echo "🔌 Backend:   http://localhost:8001"
        echo "🗄️  MongoDB:   localhost:27017"
        echo ""
        ;;
    down)
        docker-compose down
        ;;
    logs)
        docker-compose logs -f
        ;;
    logs-backend)
        docker-compose logs -f backend
        ;;
    logs-frontend)
        docker-compose logs -f frontend
        ;;
    logs-mongo)
        docker-compose logs -f mongodb
        ;;
    bash)
        docker exec -it escolaconnect-backend bash
        ;;
    shell)
        docker exec -it escolaconnect-frontend sh
        ;;
    clean)
        docker-compose down -v
        echo "✅ Cleaned up!"
        ;;
    help|--help|-h|"")
        show_help
        ;;
    *)
        echo "Unknown command: $1"
        show_help
        exit 1
        ;;
esac
