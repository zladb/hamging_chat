# Hamging Chat

## 📝 프로젝트 소개

이 프로젝트는 Flutter와 Firebase를 활용하여 개발한 실시간 채팅 애플리케이션입니다. Android, iOS, 웹 플랫폼에서 모두 동작하도록 설계되었습니다. 사용자들은 회원가입을 통해 계정을 생성하고 다른 사용자들과 채팅할 수 있습니다. 또한 프로필을 수정하고 다른 사용자를 검색하는 등의 기능도 포함되어 있습니다.  

<br/>

## 🫡 try Hamging Chat
- link: https://zladb.github.io  

<br/>

## ⭐ 주요 기능

1. 회원가입 및 로그인: 사용자는 이메일과 비밀번호를 사용하여 회원가입하고 로그인할 수 있습니다.
2. 프로필 수정: 사용자는 프로필 사진과 닉네임 등의 정보를 수정할 수 있습니다.
3. 유저 검색: 다른 사용자를 검색하여 친구 추가 및 채팅을 시작할 수 있습니다.
4. 실시간 채팅: 사용자는 실시간으로 메시지를 주고받을 수 있습니다.

<br/>

**✔️ 회원가입 및 로그인**  
- 실제 이메일로 회원가입을 진행합니다.
- 이메일과 비밀번호를 입력하고 이메일로 전송된 인증 메일을 확인합니다.
<img src="https://github.com/zladb/chatting_application/assets/68093782/792d3aab-f00c-45d2-867b-5643682d5933" width=30% />
<img src="https://github.com/zladb/chatting_application/assets/68093782/1e5cb9f5-f606-44f4-a5cd-a9dc1753e045" width=30% />
<img src="https://github.com/zladb/chatting_application/assets/68093782/18682943-812f-4ee7-af9e-d5e033303dca" width=30% />

<br/>
<br/>

**✔️ 프로필 수정**
- 첫 로그인 후 프로필을 설정합니다.
- 원하는 사진과 이름, 자기소개를 입력합니다.
- '마이페이지' 탭에서는 언제든지 프로필을 수정할 수 있습니다.
<img src="https://github.com/zladb/chatting_application/assets/68093782/852a3c33-f164-45c7-a8ae-374aefef9d1e" width=30% />
<img src="https://github.com/zladb/chatting_application/assets/68093782/7e5535d8-5d41-4d61-a348-34c445e54f36" width=30% />
<img src="https://github.com/zladb/chatting_application/assets/68093782/61805ac3-cfb7-4335-b09c-65525178620f" width=30% />

<br/>
<br/>

**✔️ 유저 검색**
- '유저 검색' 탭에 들어가면 hamging Chat을 사용하는 모든 유저 리스트를 볼 수 있습니다.
- 유저의 이름을 검색해서 프로필을 확인할 수 있습니다.
- 유저의 프로필에서 채팅을 시작할 수 있습니다.
<img src="https://github.com/zladb/chatting_application/assets/68093782/8edc8b9d-531f-4856-a5a0-33576d67dbb6" width=30% />
<img src="https://github.com/zladb/chatting_application/assets/68093782/39eee894-18a3-4ad4-b7e7-0f7b2da68bdb" width=30% />
<img src="https://github.com/zladb/chatting_application/assets/68093782/aae5ee4c-0384-4cf1-88cc-0c98e825f531" width=30% />

<br/>
<br/>

**✔️ 실시간 채팅**
- 상대방에게 메세지를 보내보세요!
- 사진도 전송 가능합니다.
- 한 번 채팅 시작하면 '채팅' 탭에서 채팅방을 확인할 수 있습니다.
<img src="https://github.com/zladb/chatting_application/assets/68093782/bb26227a-0107-4de4-a188-47531c680fa4" width=30% />
<img src="https://github.com/zladb/chatting_application/assets/68093782/c40d7330-17ed-4405-a9a8-e4c760f18aab" width=30% />
<img src="https://github.com/zladb/chatting_application/assets/68093782/e5699542-3f5c-4e8a-8880-1c17e442a18e" width=30% />


<br/>
<br/>

## 🔧 Stack

**Frontend(Web)**
- **Language** : Dart
- **Library & Framework** : Flutter
- **IDE** : android studio
<br />

**Backend**
- **Database** : Firebase(Storage)
- **Deploy**: github Action

<br/>

## 🐚 프로젝트 lib directory 구성

```
lib
  ├─component
  ├─const
  ├─layout
  ├─manager
  ├─model
  ├─provider
  ├─route
  ├─screen
  │  ├─chat
  │  ├─navigation
  │  ├─search
  │  └─user
  │      ├─login
  │      ├─mypage
  │      └─register
  ├─service
  └─utils
```

<br/>

## 🙋‍♂️ Developer

* **Yujin KIM** - 프로젝트 기획, 구상, 디자인, 개발, 배포, 관리 - [zladb](https://github.com/zladb)

<br/>

## 👾 Source



<br/>

## ✅ License

MIT License

Copyright (c) [year] [fullname]

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

