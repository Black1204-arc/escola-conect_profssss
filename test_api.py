"""
Script para testar a API do EscolaConnect
Rode: python test_api.py
"""

import requests
import json

BASE_URL = "http://localhost:8001"

def test_health():
    """Testa conexão com API"""
    try:
        response = requests.get(f"{BASE_URL}/api/")
        print("✅ Health Check:")
        print(f"   Status: {response.status_code}")
        print(f"   Response: {json.dumps(response.json(), indent=2, ensure_ascii=False)}\n")
    except Exception as e:
        print(f"❌ Health Check Failed: {e}\n")

def test_stats():
    """Testa endpoint de estatísticas"""
    try:
        response = requests.get(f"{BASE_URL}/api/stats")
        print("✅ Statistics:")
        print(f"   Response: {json.dumps(response.json(), indent=2)}\n")
    except Exception as e:
        print(f"❌ Statistics Failed: {e}\n")

def test_create_user():
    """Cria um novo usuário"""
    user_data = {
        "name": "João Silva",
        "email": "joao@example.com",
        "role": "teacher"
    }
    try:
        response = requests.post(f"{BASE_URL}/api/users", json=user_data)
        print("✅ Create User:")
        print(f"   Request: {json.dumps(user_data, indent=2, ensure_ascii=False)}")
        print(f"   Response: {json.dumps(response.json(), indent=2, ensure_ascii=False)}\n")
    except Exception as e:
        print(f"❌ Create User Failed: {e}\n")

def test_list_users():
    """Lista todos os usuários"""
    try:
        response = requests.get(f"{BASE_URL}/api/users")
        print("✅ List Users:")
        print(f"   Total: {len(response.json())} usuarios")
        if response.json():
            print(f"   First: {json.dumps(response.json()[0], indent=2, ensure_ascii=False)}\n")
    except Exception as e:
        print(f"❌ List Users Failed: {e}\n")

def test_create_student():
    """Cria um novo aluno"""
    student_data = {
        "name": "Maria Santos",
        "matricula": "2024001",
        "class": "9º A"
    }
    try:
        response = requests.post(f"{BASE_URL}/api/students", json=student_data)
        print("✅ Create Student:")
        print(f"   Request: {json.dumps(student_data, indent=2, ensure_ascii=False)}")
        print(f"   Response: {json.dumps(response.json(), indent=2, ensure_ascii=False)}\n")
    except Exception as e:
        print(f"❌ Create Student Failed: {e}\n")

def test_list_students():
    """Lista todos os alunos"""
    try:
        response = requests.get(f"{BASE_URL}/api/students")
        print("✅ List Students:")
        print(f"   Total: {len(response.json())} alunos")
        if response.json():
            print(f"   First: {json.dumps(response.json()[0], indent=2, ensure_ascii=False)}\n")
    except Exception as e:
        print(f"❌ List Students Failed: {e}\n")

if __name__ == "__main__":
    print("\n" + "="*50)
    print("🎓 EscolaConnect - API Test Suite")
    print("="*50 + "\n")
    
    test_health()
    test_stats()
    test_create_user()
    test_list_users()
    test_create_student()
    test_list_students()
    
    print("="*50)
    print("✅ Testes concluídos!")
    print("="*50)
