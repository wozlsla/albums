# Albums

## Demo

[Video link](https://imgur.com/a/7j1xqh2 "imgur")

https://github.com/user-attachments/assets/4b82af52-9053-48e6-99c3-7f89530ae6cf

</br>
</br>

## Details

**Packages**

- Flutter Animate
- Lottie
- API: http, flutter_dotenv  
  </br>

**Data (API)**  
Nexon Open API: [MapleStory](https://openapi.nexon.com/game/maplestory/?id=14)

- 각 캐릭터 상세(스탯) 페이지 진입 시 데이터 로드
  - Cache (현재 5개의 캐릭터로 제한 해 두었기 때문에 아래와 같이 구현)
  - 한 번 불러온 stat은 다시 요청하지 않음
  - Map<ocid, stat> 형태로 보관
- Background 이미지 : 나무위키
- 캐릭터의 World 는 현재 다양하지 않아서 Map으로 저장해두고 이미지 위젯을 조건부 렌더링
- 주요 스탯 강조
  </br>

**UI**

- 경계를 입체적으로, 카드에 투과되는 느낌 - BoxShadow를 활용하여 구현
