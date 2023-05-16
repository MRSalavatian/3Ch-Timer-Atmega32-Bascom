$regfile = "m32def.dat"
$crystal = 11059200
'****************************
Config Watchdog = 1024
Start Watchdog
Reset Watchdog
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

Led1 Alias Portb.4 : Config Led1 = Output
Led2 Alias Portb.3 : Config Led2 = Output
Led3 Alias Portb.2 : Config Led3 = Output
Key1 Alias Pinb.0 : Config Key1 = Input
Key2 Alias Pinb.1 : Config Key2 = Input
Key3 Alias Pinb.2 : Config Key3 = Input
Relay1 Alias Portb.2 : Config Relay1 = Output
Relay2 Alias Portb.3 : Config Relay2 = Output
Relay3 Alias Portb.4 : Config Relay3 = Output
'****************************

'****************************

'****************************
Dim I As Word
Dim Ii As Word
Dim Digit As Word
Dim Count As Word

Dim minn As Byte
Dim Secc As Byte
Dim Varseg1 As Word
Dim Varseg2 As Word
Dim Varseg3 As Word
Dim Varseg4 As Word
Dim Segdata As Byte


Const Waitforseg = 1
'****************************

'****************************
Secc = 99
Do

   Incr Minn
   Decr Secc
   For I = 1 To 60
      Gosub Refresh
   Next I







Loop
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
'(
   If Segdata = 0 Then
      Seg_a = 0
      Seg_b = 0
      Seg_c = 0
      Seg_d = 0
      Seg_e = 0
      Seg_f = 0
      Seg_g = 1
   End If

   If Segdata = 1 Then
      Seg_a = 1
      Seg_b = 0
      Seg_c = 0
      Seg_d = 1
      Seg_e = 1
      Seg_f = 1
      Seg_g = 1
   End If

   If Segdata = 2 Then
      Seg_a = 0
      Seg_b = 0
      Seg_c = 1
      Seg_d = 0
      Seg_e = 0
      Seg_f = 1
      Seg_g = 0
   End If

   If Segdata = 3 Then
      Seg_a = 0
      Seg_b = 0
      Seg_c = 0
      Seg_d = 0
      Seg_e = 1
      Seg_f = 1
      Seg_g = 0
   End If

   If Segdata = 4 Then
      Seg_a = 1
      Seg_b = 0
      Seg_c = 0
      Seg_d = 1
      Seg_e = 1
      Seg_f = 0
      Seg_g = 0
   End If

   If Segdata = 5 Then
      Seg_a = 0
      Seg_b = 1
      Seg_c = 0
      Seg_d = 0
      Seg_e = 1
      Seg_f = 0
      Seg_g = 0
   End If

   If Segdata = 6 Then
      Seg_a = 0
      Seg_b = 1
      Seg_c = 0
      Seg_d = 0
      Seg_e = 0
      Seg_f = 0
      Seg_g = 0
   End If

   If Segdata = 7 Then
      Seg_a = 0
      Seg_b = 0
      Seg_c = 0
      Seg_d = 1
      Seg_e = 1
      Seg_f = 1
      Seg_g = 1
   End If

   If Segdata = 8 Then
      Seg_a = 0
      Seg_b = 0
      Seg_c = 0
      Seg_d = 0
      Seg_e = 0
      Seg_f = 0
      Seg_g = 0
   End If

   If Segdata = 9 Then
      Seg_a = 0
      Seg_b = 0
      Seg_c = 0
      Seg_d = 0
      Seg_e = 1
      Seg_f = 0
      Seg_g = 0
   End If

   If Segdata = 99 Then
      Seg_a = 1
      Seg_b = 1
      Seg_c = 1
      Seg_d = 1
      Seg_e = 1
      Seg_f = 1
      Seg_g = 1
   End If
')
'****************************
