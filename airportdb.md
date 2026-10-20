# airportdb 簡易ER図

```mermaid
flowchart TB
    airport["airport<br/>空港"]
    airport_geo["airport_geo<br/>空港地理情報"]
    airport_reachable["airport_reachable<br/>到達可能空港"]
    airline["airline<br/>航空会社"]
    airplane["airplane<br/>航空機"]
    airplane_type["airplane_type<br/>航空機種"]
    flight["flight<br/>運航便"]
    flightschedule["flightschedule<br/>運航スケジュール"]
    booking["booking<br/>予約"]
    passenger["passenger<br/>乗客"]
    passengerdetails["passengerdetails<br/>乗客詳細"]
    employee["employee<br/>従業員"]
    flight_log["flight_log<br/>運航履歴"]
    weatherdata["weatherdata<br/>気象データ"]

   %% リレーション（つながり）
    airport --- airport_geo
    airport --- airport_reachable
    airport --- flight
    airport --- flightschedule
    airport --- airline
    
    airline --- flight
    airline --- flightschedule

    airplane_type --- airplane
    airplane --- flight

    flightschedule --- flight
    flight --- booking
    passenger --- booking
    passenger --- passengerdetails
    flight --- flight_log