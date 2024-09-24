import pandas as pd
from pyproj import Proj, transform

# TM 좌표계 정의 (EPSG:5186 - 한국 중부 원점)
tm_proj = Proj(init='epsg:5186')

# WGS84 좌표계 정의 (EPSG:4326)
wgs84_proj = Proj(init='epsg:4326')

# TM 좌표 (X, Y) -> WGS84 좌표 (경도, 위도) 변환 함수
def tm_to_wgs84(x, y):
    lon, lat = transform(tm_proj, wgs84_proj, x, y)
    return lon, lat

# 엑셀 파일에서 데이터 읽기
input_file = "C:/Users/yourboot/Desktop/테스트.xlsx"
df = pd.read_excel(input_file)

# FXCOORD와 FYCOORD 열의 TM 좌표를 WGS 84 좌표로 변환
df['Longitude'], df['Latitude'] = zip(*df.apply(lambda row: tm_to_wgs84(row['FXCOORD'], row['FYCOORD']), axis=1))

# 결과를 새로운 엑셀 파일로 저장
output_file = "C:/Users/yourboot/Desktop/테스트2.xlsx"  # 파일 이름 확인
df.to_excel(output_file, index=False)

print(f"변환된 데이터를 {output_file} 파일로 저장했습니다.")
