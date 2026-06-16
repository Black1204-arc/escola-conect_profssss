#!/usr/bin/env node

/**
 * Basic Integration Tests for EscolaConnect V2.0
 * 
 * Tests:
 * 1. Health check
 * 2. Login with test credentials
 * 3. Get user info
 * 4. Create new user
 * 5. Get users list
 */

const BASE_URL = 'http://localhost:8001/api';
const FRONTEND_URL = 'http://localhost:3000';

const colors = {
  reset: '\x1b[0m',
  green: '\x1b[32m',
  red: '\x1b[31m',
  yellow: '\x1b[33m',
  blue: '\x1b[36m',
};

async function request(method, path, body = null, token = null) {
  const url = `${BASE_URL}${path}`;
  const options = {
    method,
    headers: {
      'Content-Type': 'application/json',
    },
  };

  if (token) {
    options.headers.Authorization = `Bearer ${token}`;
  }

  if (body) {
    options.body = JSON.stringify(body);
  }

  const response = await fetch(url, options);
  const data = await response.json();

  return { status: response.status, data };
}

async function test(name, fn) {
  try {
    process.stdout.write(`${colors.blue}⏳ ${name}... ${colors.reset}`);
    await fn();
    console.log(`${colors.green}✓ PASS${colors.reset}`);
    return true;
  } catch (error) {
    console.log(`${colors.red}✗ FAIL${colors.reset}`);
    console.log(`   ${colors.red}${error.message}${colors.reset}`);
    return false;
  }
}

async function main() {
  console.log('\n' + '='.repeat(60));
  console.log(`${colors.blue}EscolaConnect V2.0 - Integration Tests${colors.reset}`);
  console.log('='.repeat(60) + '\n');

  let token = null;
  let passed = 0;
  let failed = 0;

  // Test 1: Health Check
  if (
    await test('Health Check', async () => {
      const response = await fetch('http://localhost:8001/health');
      if (response.status !== 200) {
        throw new Error(`Expected status 200, got ${response.status}`);
      }
    })
  ) {
    passed++;
  } else {
    failed++;
  }

  // Test 2: Login
  if (
    await test('Login with Admin', async () => {
      const { status, data } = await request('POST', '/auth/login', {
        email: 'admin@escolaconnect.com',
        senha: 'admin123',
      });

      if (status !== 200 || !data.data?.token) {
        throw new Error(`Login failed: ${JSON.stringify(data)}`);
      }

      token = data.data.token;
    })
  ) {
    passed++;
  } else {
    failed++;
  }

  if (!token) {
    console.log(
      `\n${colors.red}Cannot continue without token. Aborting tests.${colors.reset}\n`
    );
    process.exit(1);
  }

  // Test 3: Get Me
  if (
    await test('Get Current User (getMe)', async () => {
      const { status, data } = await request('GET', '/auth/me', null, token);

      if (status !== 200 || !data.data?.email) {
        throw new Error(`getMe failed: ${JSON.stringify(data)}`);
      }

      if (data.data.email !== 'admin@escolaconnect.com') {
        throw new Error('Expected admin user');
      }
    })
  ) {
    passed++;
  } else {
    failed++;
  }

  // Test 4: Get Users List
  if (
    await test('Get Users List', async () => {
      const { status, data } = await request('GET', '/users', null, token);

      if (status !== 200 || !Array.isArray(data.data)) {
        throw new Error(`getUsers failed: ${JSON.stringify(data)}`);
      }

      if (data.data.length === 0) {
        throw new Error('Expected at least one user');
      }
    })
  ) {
    passed++;
  } else {
    failed++;
  }

  // Test 5: Frontend Access
  if (
    await test('Frontend Accessibility', async () => {
      const response = await fetch(FRONTEND_URL);
      if (response.status !== 200) {
        throw new Error(`Frontend returned ${response.status}`);
      }
    })
  ) {
    passed++;
  } else {
    failed++;
  }

  // Test 6: Create User
  if (
    await test('Create New User', async () => {
      const { status, data } = await request(
        'POST',
        '/users',
        {
          email: `test_${Date.now()}@teste.com`,
          nome: 'Usuário Teste',
          senha: 'test1234',
          role: 'aluno',
        },
        token
      );

      if (status !== 201 || !data.data?.id) {
        throw new Error(`Create user failed: ${JSON.stringify(data)}`);
      }
    })
  ) {
    passed++;
  } else {
    failed++;
  }

  // Results
  console.log('\n' + '='.repeat(60));
  console.log(`${colors.blue}Test Results${colors.reset}`);
  console.log('='.repeat(60));
  console.log(
    `${colors.green}✓ Passed: ${passed}${colors.reset}  ${colors.red}✗ Failed: ${failed}${colors.reset}`
  );
  console.log('='.repeat(60) + '\n');

  if (failed > 0) {
    process.exit(1);
  }
}

main().catch((error) => {
  console.error(`${colors.red}Fatal error: ${error.message}${colors.reset}`);
  process.exit(1);
});
