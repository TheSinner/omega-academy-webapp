-- 관리자 계정 생성 (전화번호: 01012345678, 비밀번호: 900101)
-- 비밀번호는 bcrypt로 암호화되어야 하므로, 나중에 API를 통해 생성하거나 직접 암호화된 값으로 변경
INSERT OR IGNORE INTO users (phone, password, name, role) VALUES 
  ('01012345678', '$2a$10$YourHashedPasswordHere', '관리자', 'admin');

-- 테스트용 학생 계정 (전화번호: 01098765432, 비밀번호: 050315)
INSERT OR IGNORE INTO users (phone, password, name, role) VALUES 
  ('01098765432', '$2a$10$YourHashedPasswordHere', '홍길동', 'student');

-- 테스트용 선생님 계정 (전화번호: 01055556666, 비밀번호: 030520)
INSERT OR IGNORE INTO users (phone, password, name, role) VALUES 
  ('01055556666', '$2a$10$YourHashedPasswordHere', '김선생', 'teacher');

-- 테스트용 조교 계정 (전화번호: 01077778888, 비밀번호: 950520)
INSERT OR IGNORE INTO users (phone, password, name, role) VALUES 
  ('01077778888', '$2a$10$YourHashedPasswordHere', '박조교', 'assistant');

-- 샘플 공지사항
INSERT OR IGNORE INTO notices (title, content, author_id) VALUES 
  ('학원 운영 안내', '오메가수학전문학원에 오신 것을 환영합니다. 이 앱을 통해 공지사항과 질문을 주고받을 수 있습니다.', 1);
