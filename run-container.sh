#!/bin/bash

echo "╔════════════════════════════════════════════════════════════╗"
echo "║                                                            ║"
echo "║     🎉 EscolaConnect V2.0 - Container Integrado 🎉        ║"
echo "║                                                            ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""
echo "Iniciando container com PostgreSQL + Backend + Frontend..."
echo ""

docker compose -f docker-compose-simple.yml up --build

echo ""
echo "Container finalizado."
