$regfile = "m32def.dat"
$crystal = 11059200
'****************************
Open "coma.5:9600,8,n,1" For Output As #1
'****************************
Config Watchdog = 1024
Start Watchdog
Reset Watchdog
'****************************
Config Timer1 = Timer , Prescale = 256 , Clear Timer = 0    '256
Enable Timer1
Enable Interrupts
Start Timer1
On Timer1 Timer_tick
'****************************
Seg1 Alias Portd.6 : Config Seg1 = Output
Seg2 Alias Portd.4 : Config Seg2 = Output
Seg3 Alias Portd.5 : Config Seg3 = Output
Seg4 Alias Portd.7 : Config Seg4 = Output
Seg_a Alias Portc.5 : Config Seg_a = Output
Seg_b Alias Portc.7 : Config Seg_b = Output
Seg_c Alias Portc.1 : Config Seg_c = Output
Seg_d Alias Portc.3 : Config Seg_d = Output
Seg_e Alias Portc.4 : Config Seg_e = Output
Seg_f Alias Portc.6 : Config Seg_f = Output
Seg_g Alias Portc.0 : Config Seg_g = Output
Dot Alias Portc.2 : Config Dot = Output
Seg1 = 0 : Seg2 = 0 : Seg3 = 0 : Seg4 = 0

Led1 Alias Porta.4 : Config Led1 = Output
Led2 Alias Porta.3 : Config Led2 = Output
Led3 Alias Porta.2 : Config Led3 = Output
Key1 Alias Pinb.7 : Config Key1 = Input
Key2 Alias Pinb.6 : Config Key2 = Input
Key3 Alias Pinb.5 : Config Key3 = Input
Relay1 Alias Portb.2 : Config Relay1 = Output
Relay2 Alias Portb.3 : Config Relay2 = Output
Relay3 Alias Portb.4 : Config Relay3 = Output
Buzzer Alias Porta.7 : Config Buzzer = Output

Up Alias Pind.0 : Config Up = Input
Down Alias Pind.1 : Config Down = Input
Okk Alias Pind.2 : Config Okk = Input
'****************************
Dim I As Word
Dim Ii As Word
Dim Digit As Word
Dim Count As Word
Dim Tick As Bit

Dim Minn As Byte
Dim Secc As Byte
Dim Varseg1 As Word
Dim Varseg2 As Word
Dim Varseg3 As Word
Dim Varseg4 As Word
Dim Segdata As Byte

Dim Off_time1 As Byte
Dim On_time1 As Byte
Dim Off_time2 As Byte
Dim On_time2 As Byte
Dim Off_time3 As Byte
Dim On_time3 As Byte
Dim Eram_off_time1 As Eram Byte
Dim Eram_on_time1 As Eram Byte
Dim Eram_off_time2 As Eram Byte
Dim Eram_on_time2 As Eram Byte
Dim Eram_off_time3 As Eram Byte
Dim Eram_on_time3 As Eram Byte

Dim Time_counter1 As Word
Dim Time_counter2 As Word
Dim Time_counter3 As Word


Dim Sec1 As Byte
Dim Sec2 As Byte
Dim Sec3 As Byte

Dim Flag As Byte


Const Waitforseg = 1
Const Delay_key = 40


Off_time1 = Eram_off_time1
Off_time2 = Eram_off_time2
Off_time3 = Eram_off_time3
On_time1 = Eram_on_time1
On_time2 = Eram_on_time2
On_time3 = Eram_on_time3
'****************************
Main:
Led1 = 0 : Led2 = 0 : Led3 = 0 : Dot = 0
Start Timer1
Gosub Beep
Do

   If Okk = 1 Then
      I = 0
      Stop Timer1
      Do
         Incr I
         Reset Watchdog
         Waitms 100
         Toggle Led1
         Toggle Led2
         Toggle Led3
         If I > 15 Then
            Led1 = 1 : Led2 = 1 : Led3 = 1
            Gosub Beep
            Gosub Ok_key_release
            Dot = 1
            Goto Menu
         End If
      Loop Until Okk = 0
      Start Timer1
      Led1 = 0 : Led2 = 0 : Led3 = 0
   End If

   If Key1 = 1 Then
      Gosub Beep
      If Flag.0 = 1 Or Flag.1 = 1 Then
         Flag.0 = 0 : Flag.1 = 0
         Time_counter1 = 0
         Led1 = 0
         Relay1 = 0
      Else
         Flag.0 = 1 : Flag.1 = 0
         Time_counter1 = On_time1
      End If
      Do
         Waitms 10
         Reset Watchdog
      Loop Until Key1 = 0
      Waitms 400
   End If


   If Key2 = 1 Then
      Gosub Beep
      If Flag.2 = 1 Or Flag.3 = 1 Then
         Flag.2 = 0 : Flag.3 = 0
         Time_counter2 = 0
         Led2 = 0
         Relay2 = 0
      Else
         Flag.2 = 1 : Flag.3 = 0
         Time_counter2 = On_time2
      End If

      Do
         Waitms 10
         Reset Watchdog
      Loop Until Key2 = 0
      Waitms 400
   End If


   If Key3 = 1 Then
      Gosub Beep
      If Flag.4 = 1 Or Flag.5 = 1 Then
         Flag.4 = 0 : Flag.5 = 0
         Time_counter3 = 0
         Led3 = 0
         Relay3 = 0
      Else
         Flag.4 = 1 : Flag.5 = 0
         Time_counter3 = On_time3
      End If
      Do
         Waitms 10
         Reset Watchdog
      Loop Until Key3 = 0
      Waitms 400
   End If

   If Time_counter1 = 0 Then
      If Flag.0 = 0 And Flag.1 = 1 Then
         Relay1 = 0
         Flag.0 = 0 : Flag.1 = 0
         Led1 = 0
         Print #1 , "Relay1=off"
      End If

      If Flag.0 = 1 And Flag.1 = 0 Then
         Relay1 = 1
         Time_counter1 = Off_time1 * 60
         Flag.0 = 0 : Flag.1 = 1

         Print #1 , "Relay1=on  T=" ; Time_counter1
      End If
   End If

   If Time_counter2 = 0 Then
      If Flag.2 = 0 And Flag.3 = 1 Then
         Relay2 = 0
         Led2 = 0
         Flag.2 = 0 : Flag.3 = 0
         Print #1 , "Relay2=off"
      End If

      If Flag.2 = 1 And Flag.3 = 0 Then
         Relay2 = 1
         Time_counter2 = Off_time2 * 60
         Flag.2 = 0 : Flag.3 = 1

         Print #1 , "Relay2=on  T=" ; Time_counter2
      End If
   End If

   If Time_counter3 = 0 Then
      If Flag.4 = 0 And Flag.5 = 1 Then
         Relay3 = 0
         Led3 = 0
         Flag.4 = 0 : Flag.5 = 0
         Print #1 , "Relay3=off"
      End If

      If Flag.4 = 1 And Flag.5 = 0 Then
         Relay3 = 1
         Time_counter3 = Off_time3 * 60
         Flag.4 = 0 : Flag.5 = 1

         Print #1 , "Relay3=on  T=" ; Time_counter3
      End If
   End If

   If Up = 1 Then
      Print #1 , "************ COUNT ************"
      Print #1 , "1)On=" ; ; "   Off=" ; Time_counter1 ; "  Relay=" ; Relay1 ; "  Flag=" ; Flag.0 ; Flag.1
      Print #1 , "2)On=" ; ; "   Off=" ; Time_counter2 ; "  Relay=" ; Relay2 ; "  Flag=" ; Flag.2 ; Flag.3
      Print #1 , "3)On=" ; ; "   Off=" ; Time_counter3 ; "  Relay=" ; Relay3 ; "  Flag=" ; Flag.4 ; Flag.5
      Waitms 500
   End If

   If Down = 1 Then
      Print #1 , "************ TIME ************"
      Print #1 , "1)On=" ; On_time1 ; "   Off=" ; Off_time1
      Print #1 , "2)On=" ; On_time2 ; "   Off=" ; Off_time2
      Print #1 , "3)On=" ; On_time3 ; "   Off=" ; Off_time3
      Waitms 500
   End If
   Waitms 1
   Reset Watchdog

   Secc = 0                                                 'Time_counter1 Mod 100
   Minn = 0                                                 'Time_counter1 / 100
   Gosub Refresh

Loop
'****************************
Beep:
   For I = 1 To 3
      Buzzer = 1
      Waitms 60
      Buzzer = 0
      Waitms 60
   Next I
Return
'****************************
Timer_tick:
   Timer1 = 22335
   Toggle Tick

   If Sec1 = 0 Then
      Sec1 = 60
      If Time_counter1 > 0 Then Decr Time_counter1
   End If
   Decr Sec1

   If Sec2 = 0 Then
      Sec2 = 60
      If Time_counter2 > 0 Then Decr Time_counter2
   End If
   Decr Sec2

   If Sec3 = 0 Then
      Sec3 = 60
      If Time_counter3 > 0 Then Decr Time_counter3
   End If
   Decr Sec3

   If Time_counter1 > 0 Then Led1 = Tick
   If Time_counter2 > 0 Then Led2 = Tick
   If Time_counter3 > 0 Then Led3 = Tick

Return
'****************************
Menu:
   Led1 = 1 : Led2 = 0 : Led3 = 0
   Minn = 0 : Secc = On_time1
   Gosub Get_value_sec
   On_time1 = Secc
   Eram_on_time1 = Secc
   Gosub Ok_key_release

   Minn = Off_time1 : Secc = 0
   Gosub Get_value_min
   Off_time1 = Minn
   Eram_off_time1 = Minn
   Gosub Ok_key_release

   Led1 = 0 : Led2 = 1 : Led3 = 0
   Minn = 0 : Secc = On_time2
   Gosub Get_value_sec
   On_time2 = Secc
   Eram_on_time2 = Secc
   Gosub Ok_key_release

   Minn = Off_time2 : Secc = 0
   Gosub Get_value_min
   Off_time2 = Minn
   Eram_off_time2 = Minn
   Gosub Ok_key_release

   Led1 = 0 : Led2 = 0 : Led3 = 1
   Minn = 0 : Secc = On_time3
   Gosub Get_value_sec
   On_time3 = Secc
   Eram_on_time3 = Secc
   Gosub Ok_key_release

   Minn = Off_time3 : Secc = 0
   Gosub Get_value_min
   Off_time3 = Minn
   Eram_off_time3 = Minn
   Gosub Ok_key_release

Goto Main

'****************************
Get_value_sec:
   Do
      Gosub Refresh
      If Up = 1 Then
         Incr Secc
         If Secc > 59 Then Secc = 1
         For I = 1 To Delay_key
            Gosub Refresh
         Next I
      End If

      If Down = 1 Then
         Decr Secc
         If Secc > 59 Then Secc = 59
         For I = 1 To Delay_key
            Gosub Refresh
         Next I
      End If

      If Okk = 1 Then Exit Do
   Loop
Return
'****************************
Get_value_min:
   Do
      Gosub Refresh
      If Up = 1 Then
         Incr Minn
         If Minn > 59 Then Minn = 1
         For I = 1 To Delay_key
            Gosub Refresh
         Next I
      End If

      If Down = 1 Then
         Decr Minn
         If Minn > 59 Then Minn = 59
         For I = 1 To Delay_key
            Gosub Refresh
         Next I
      End If

      If Okk = 1 Then Exit Do
   Loop
Return
'****************************
Ok_key_release:
  Do
     Waitms 10
     Reset Watchdog
  Loop Until Okk = 0
  Waitms 300
Return
'****************************
Refresh:
   Varseg1 = Minn / 10
   Varseg2 = Minn Mod 10
   Varseg3 = Secc / 10
   Varseg4 = Secc Mod 10

   Seg1 = 1 : Segdata = Varseg1 : Gosub Refreshseg : Waitms Waitforseg : Seg1 = 0 : Segdata = 99 : Gosub Refreshseg       ': Waitms Waitforseg
   Seg2 = 1 : Segdata = Varseg2 : Gosub Refreshseg : Waitms Waitforseg : Seg2 = 0 : Segdata = 99 : Gosub Refreshseg       ': Waitms Waitforseg
   Seg3 = 1 : Segdata = Varseg3 : Gosub Refreshseg : Waitms Waitforseg : Seg3 = 0 : Segdata = 99 : Gosub Refreshseg       ': Waitms Waitforseg
   Seg4 = 1 : Segdata = Varseg4 : Gosub Refreshseg : Waitms Waitforseg : Seg4 = 0 : Segdata = 99 : Gosub Refreshseg       ': Waitms Waitforseg
   Reset Watchdog
Return
'****************************
Refreshseg:
   If Segdata = 0 Then
      Seg_a = 1
      Seg_b = 1
      Seg_c = 1
      Seg_d = 1
      Seg_e = 1
      Seg_f = 1
      Seg_g = 0
   End If

   If Segdata = 1 Then
      Seg_a = 0
      Seg_b = 1
      Seg_c = 1
      Seg_d = 0
      Seg_e = 0
      Seg_f = 0
      Seg_g = 0
   End If

   If Segdata = 2 Then
      Seg_a = 1
      Seg_b = 1
      Seg_c = 0
      Seg_d = 1
      Seg_e = 1
      Seg_f = 0
      Seg_g = 1
   End If

   If Segdata = 3 Then
      Seg_a = 1
      Seg_b = 1
      Seg_c = 1
      Seg_d = 1
      Seg_e = 0
      Seg_f = 0
      Seg_g = 1
   End If

   If Segdata = 4 Then
      Seg_a = 0
      Seg_b = 1
      Seg_c = 1
      Seg_d = 0
      Seg_e = 0
      Seg_f = 1
      Seg_g = 1
   End If

   If Segdata = 5 Then
      Seg_a = 1
      Seg_b = 0
      Seg_c = 1
      Seg_d = 1
      Seg_e = 0
      Seg_f = 1
      Seg_g = 1
   End If

   If Segdata = 6 Then
      Seg_a = 1
      Seg_b = 0
      Seg_c = 1
      Seg_d = 1
      Seg_e = 1
      Seg_f = 1
      Seg_g = 1
   End If

   If Segdata = 7 Then
      Seg_a = 1
      Seg_b = 1
      Seg_c = 1
      Seg_d = 0
      Seg_e = 0
      Seg_f = 0
      Seg_g = 0
   End If

   If Segdata = 8 Then
      Seg_a = 1
      Seg_b = 1
      Seg_c = 1
      Seg_d = 1
      Seg_e = 1
      Seg_f = 1
      Seg_g = 1
   End If

   If Segdata = 9 Then
      Seg_a = 1
      Seg_b = 1
      Seg_c = 1
      Seg_d = 1
      Seg_e = 0
      Seg_f = 1
      Seg_g = 1
   End If

   If Segdata = 99 Then
      Seg_a = 0
      Seg_b = 0
      Seg_c = 0
      Seg_d = 0
      Seg_e = 0
      Seg_f = 0
      Seg_g = 0
   End If
Return
'****************************





