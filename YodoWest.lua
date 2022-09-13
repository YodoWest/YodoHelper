script_author("Yodo_West")
script_name("YodoWest")

--------------------------------------------------------------------------------
------------------------------------LIBRARIES-----------------------------------
--------------------------------------------------------------------------------

require "lib.moonloader"
require "lib.sampfuncs"
local dlstatus = require('moonloader').download_status
local inicfg = require 'inicfg'
local keys = require "vkeys"
local imgui = require 'imgui'

local ffi = require "ffi"
ffi.cdef[[
     void keybd_event(int keycode, int scancode, int flags, int extra);
]]

local sampev = require 'samp.events'

local rkeys = require 'rkeys'
imgui.HotKey = require('imgui_addons').HotKey

local tLastKey = {}

local encoding = require 'encoding'
encoding.default = 'CP1251'
u8 = encoding.UTF8

--------------------------------------------------------------------------------
-------------------------------------LOAD INI-----------------------------------
--------------------------------------------------------------------------------

update_state = false

local script_vers = 1.1
local script_vers_text = "1.01"

local update_url = "https://raw.githubusercontent.com/YodoWest/YodoHelper/main/update.ini" 
local update_path = getWorkingDirectory() .. "/update.ini"

local script_url = "https://raw.githubusercontent.com/YodoWest/YodoHelper/main/YodoWest.lua" 
local script_path = thisScript().path

local tag = "{FFFF00}[YodoHelper] {FFFFFF}By {FFFF00}Yodo_West :)"

local main_window_state = imgui.ImBool(false)
local two_window_state = imgui.ImBool(false)

function EmulateKey(key, isDown)
    if not isDown then
        ffi.C.keybd_event(key, 0, 2, 0)
    else
        ffi.C.keybd_event(key, 0, 0, 0)
    end
end


function main()
    if not isSampLoaded() or not isSampfuncsLoaded() then return end
	while not isSampAvailable() do wait(100) end
	sampAddChatMessage("" .. tag, main_color)
	sampRegisterChatCommand("update", cmd_update)
	sampRegisterChatCommand("klot", cmd_klot)

	_, id = sampGetPlayerIdByCharHandle(PLAYER_PED)
	nick = sampGetPlayerNickname(id)

	imgui.Process = false
		
	downloadUrlToFile(update_url, update_path, function(id, status)
		if status == dlstatus.STATUS_ENDDOWNLOADDATA then
			updateini = inicfg.load(nil, update_path)
			if tonumber(updateini.info.vers) > script_vers then
				sampAddChatMessage('���� ���������� �������!', 0xFFFFFF)
				update_state = true
			end
			os.remove(update_path)
		end
	end)

  	while true do
		wait(0)

		if main_window_state.v == false then
			imgui.Process = false
		end

		if two_window_state.w == false then
			imgui.Process = false
		end

		------Buy_Materials------
		
			if isKeyJustPressed(VK_J) and not sampIsChatInputActive() and not sampIsChatInputActive() and not isPauseMenuActive() and not isSampfuncsConsoleActive() then
				EmulateKey(18, true)
				wait(5)
				EmulateKey(18, false)
				wait(8)
				EmulateKey(13, true)
				wait(5)
				EmulateKey(13, false)
			end

		 ------No_Buy_Materials------

		if update_state then
			downloadUrlToFile(script_url, update_path, function(id, status)
				if status == dlstatus.STATUS_ENDDOWNLOADDATA then
					sampAddChatMessage('������ �������!', 0xFFFFFF)
					thisScript():reload()
				end
			end)
			break
		end
	end
end

function cmd_update(arg)
    sampShowDialog(1000, "��������������! v1.0", "{FFFFFF}���������� ����", "�������", "", 0)
end

function cmd_klot(arg)
	main_window_state.v = not main_window_state.v
	imgui.Process = main_window_state.v
end

function imgui.OnDrawFrame()
	if main_window_state.v then
		local sw, sh = getScreenResolution()
		imgui.SetNextWindowPos(imgui.ImVec2(sw / 2, sh / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(705, 539), imgui.Cond.FirstUseEver)

			imgui.Begin(u8'������ �� �����', main_window_state)

			local filterBuf = imgui.ImBuffer('', 360)
			local text =
			{
				u8'1)������� ���� �������� 7 ������� Mesa � ������� xx.xx.xx | �����: 06.01.18',
				'Apply',
				'Phone'
			}

			if imgui.CollapsingHeader(u8'�����') then
				imgui.InputText('Filter', filterBuf)
				if filterBuf.v:len() ~= 0 then
					for i = 1, #text do
						if string.find(text[i], filterBuf.v) then
							imgui.Text(text[i])
						end
					end
				end
			end

			imgui.Text(u8'1)������� ���� �������� 7 ������� Mesa � ������� xx.xx.xx | �����: 06.01.18')

			imgui.Text(u8'2)������� ���� �������� 8 ������� Red-Rock � ������� xx.xx.xx | �����: 26.07.18')

			imgui.Text(u8'3)������� ���� �������� 9 ������� Yuma � ������� xx.xx.xx | �����: 06.01.19')

			imgui.Text(u8'4)������� ���� �������� 12 ������� Glendale � ������� xx.xx.xx | �����: 01.04.20')

			imgui.Text(u8'5)������� ���� �������� 13 ������� Kingman � ������� xx.xx.xx | �����: 28.04.20')

			imgui.Text(u8'6)������� ���� �������� 15 ������� Payson � ������� xx.xx.xx | �����: 04.01.21')

			imgui.Text(u8'7)������� ���� �������� 16 ������� Gilbert � ������� xx.xx.xx | �����: 09.05.21')

			imgui.Text(u8'8)��� ����� �������� ��������� �������� �� �������� �����������? | �����: ������')

			imgui.Text(u8'9)��� ����� ����� ��������� �������� � �������������� �������� ��������� ? | �����: ���������')

			imgui.Text(u8'10)��� ����� �������� �������� � ����� ? | �����: �����')

			imgui.Text(u8'11)����� ������� ������� ��������� ��� ���� ����� �������� �� ������ �������� ? | �����: 7')

			imgui.Text(u8'12)����� ������� ������� ��������� ��� ���� ����� �������� �� ������ ����������� ? | �����: 6')

			imgui.Text(u8'13)����� ���������� ����� � ������� "�������������� �����"? | �����: 212')

			imgui.Text(u8'14)����� ���������� ����� � ������� �����-�������� ? | �����: 144')

			imgui.Text(u8'15)����� ���������� ����� � ������� "���������" | �����: 126')

			imgui.Text(u8'16)������� ���������� ����� � ����� �2 |�����: 42')

			imgui.Text(u8'17)������� ���������� ����� � ����� �3 | �����: 46')

			imgui.Text(u8'18)������� ���������� ����� � ����� �5 | �����: 61')

			imgui.Text(u8'19)������� ������� �������� ����� ����� ������� "����� ������" � �������� �������� ? | �����: 2900')

			imgui.Text(u8'20)������ ��� ��������� ����� ������� ����? | �����: 25600000')

			imgui.Text(u8'21)������� ����� ������� ����� ����� ���������� ����� ? | �����: 400')

			imgui.Text(u8'22)������ : ������� ����� �������� ���������� | �����: 156')

			imgui.Text(u8'23)������������ ���� � �� Los Santos Tower ? | �����: 13')

			imgui.Text(u8'24)������: ������� ����� ����� �� ����������� "����������"? | �����: 30000')

			imgui.Text(u8'25)������: ������� ���������� ���������� ��������� �� ������� | �����: 8')

			imgui.Text(u8'26)������ : ������� ����� ����� ��� ������ ���������� ������� ������� ���� ? | �����: 5000')

			imgui.Text(u8'27)� ����� ���� ���� ��������� "���������" �� ������ ? | �����: 2017')

			imgui.Text(u8'28)����� ������������ ����� ������ ����� ���� �������� �� ������ ���������� ? | �����: 80000')

			imgui.Text(u8'29)������� ������� �������� ����� ����� ������� "���������� �����" � �������� �������� ? | �����: 2400')

			imgui.Text(u8'30) ����� ���. ���� ������� - �������������������� �������? | �����: 45000000')

			imgui.Text(u8'31)������� ���� ����� � �������� ����� ��� ������� ? | �����: 5')

			imgui.Text(u8'32)��� ������� ����. �������������� �������? | �����: Swe�t_Jonson')

			imgui.Text(u8'33)������� ����� ����� ��������� "�����" ��� �����? | �����: 80000000')

			imgui.Text(u8'34)������� ����� ����������� ������ ��� ���������� �������? | �����: 5000')

			imgui.Text(u8'35)������� ����� ����������� ����������� �������� � ������� � ���������� ? | �����: 14')

			imgui.Text(u8'36)��������� ������ � ����������� | �����: 4000000')

			imgui.Text(u8'37)����� ������� � ������������ ������� ? | �����: ���������')

			imgui.Text(u8'38)��� ����� ����� ��������� �������� � �������� �� ? | �����: �����')

			imgui.Text(u8'39)������� ����� ��������� ������������ �� �� �� ? | �����: 7')

			imgui.Text(u8'40)����������� ������ �� Premium ��������� | �����: 15000000')

			imgui.Text(u8'41)����� ���. ���� ������� "����������" ? | �����: 60000000')

			imgui.Text(u8'42)� ����� ������ ������������ ����� ������ �� �� �� ? | �����: �������')

			imgui.Text(u8'43)������� ����� ���������� VIP-�����? | �����: 2500000')

			imgui.Text(u8'44)����� ���������� ���� ����� ����� ����� PREMIUM VIP ? | �����: 20')

			imgui.Text(u8'45)������� ����� ������� ���� �� ����� ? | �����: 200000')

			imgui.Text(u8'46)������ ���. ��������� ����� ������� ����� ? | �����: 50000000')

			imgui.Text(u8'47)�� ����� ����������� ����� � ������� ������� �������� ���� ? | �����: ����������')

			imgui.Text(u8'48) ������� ����� ���������� ������������ ����� | �����: 8828')

			imgui.Text(u8'49)������� ����� ��������� ������ � ���������? | �����: 900')

			imgui.Text(u8'50)��� ��������� �����, ������� ����� �� ��� ��������, � ����� ������? | �����: NewIsland')

			imgui.Text(u8'51)������� ����� ������ ���� �� ������� ? | �����: 5')

			imgui.Text(u8'52)������� ���������� ����� � ����� �1 | �����: 24')

			imgui.Text(u8'53)������� ������ ���������� ��������� ��������� | �����: 3')

			imgui.Text(u8'54)������ ���. ��������� �������� �������� ������ | �����: 3500000')

			imgui.Text(u8'55)������� ������� ����� ����� ����� ������� "������ �������" � ���������� ����� ? | �����: 1300')

			imgui.Text(u8'56)������� ������� �������� ����� ����� ������� "������ ��������" � �������� �������� ? | �����: 2800')

			imgui.Text(u8'57)�� ����� ����� ����� ��������� ����� ������� ����� ? | �����: 913')

			imgui.Text(u8'58)������ ��������� ������ �� ��������� ������ ������ ? | �����: 20000000')

			imgui.Text(u8'59)������� ����� ������ � VIP ��� ������ ? | �����: 50000')

			imgui.Text(u8'60)������������ ����� ������������� � ������������������� ? | �����: 100000000')

			imgui.Text(u8'61)��� ����� ��������� ������� ������ ��������� ����� ������� �� ������� ? | �����: �������')

			imgui.Text(u8'62)����� ������� ������� ����� ���������� ����� ������� ���� ����� ? | �����: 20')

			imgui.Text(u8'63)�� ����� ����� ����� ��������� ����� ������� �������� ? | �����: 914')

			imgui.Text(u8'64)������� ���� �������� 10 ������� Surprise � ������� xx.xx.xx | �����: 25.07.19')

			imgui.Text(u8'65)��� ������� ��������� ������� Arizona RP ? | �����: �����')

			imgui.Text(u8'66)����� ���������� ����� � ������� "������ �����������" | �����: 215')

			imgui.Text(u8'67)�� ����� ����� ����� ��������� ����� ������� ������ ������ ? | �����: 912')

			imgui.Text(u8'68)������� ����� �������� ����� ����� ? | �����: 20000000')

			imgui.Text(u8'69)����� ������� ������� ��������� ��� ���� ����� �������� �� ������ �������� ������� ? | �����: 9')

			imgui.Text(u8'70)����� ������� ������� ��������� ��� ���� ����� �������� �� ������ ������ ? | �����: 5')

			imgui.Text(u8'71)������� ����� ���� �������� � ������� �������� ������ ? | �����: 5')

			imgui.Text(u8'72)����� ������� ������� ��������� ��� ���� ����� �������� �� ������ ������������� ? | �����: 5')

			imgui.Text(u8'73)����� ������� ������� ��������� ��� ���� ����� �������� �� ������ ���������� ����� ? | �����: 10')

			imgui.Text(u8'74)����� ���������� �������� �������� ��� ������ �������������� �� ������� ����� ���� �������? | �����:6')

			imgui.Text(u8'75)����� ����� ����� ��� ���� ����� ���������������� ������ �� ����� ? | �����: 1500000000')

			imgui.Text(u8'76)��� ����� ��������� ������� �������� ���������� ������� �� ����������� ����� ? | �����: ������')

			imgui.Text(u8'77)������� ������� ����� ����� ����� ������� "����" � ���������� �����? | �����: 600')

			imgui.Text(u8'78)����� ������� ������� ��������� ��� ���� ����� �������� �� ������ ��������? | �����: 3')

			imgui.Text(u8'79)������� ������� ����� ����� ����� ������� "������" � ���������� �����? | �����: 1000')

			imgui.Text(u8'80)������� �������� ����� ����������� �� ������ ���. ���������� ������ PayDay ? | �����: 8')

			imgui.Text(u8'81)������� ����������� ����� ��� ������� � ������ ��������� | �����: 10000')

			imgui.Text(u8'82)��� ����� ��, ������� ��������� ������ ������� � ���� � ����� ? | �����: ������')

			imgui.Text(u8'83)��������� ������ ����� �8 �� ����������� ����� ? | �����: 100000')

			imgui.Text(u8'84)������� ���� �������� 6 ������� Saint Rose � ������� xx.xx.xx | �����: 27.08.17')

			imgui.Text(u8'85)��� ����� ��������� ������� ����� ��� ������ ����� � ����� ����� Ballas ? | �����: ���� ���')

			imgui.Text(u8'86)������� ���������� ����� � ����� �4 | �����: 35')

			imgui.Text(u8'87)������� ������������� �������� ��� ������������ �� ������� ? | �����: 3')

			imgui.Text(u8'88)������ ��������� 1 ����� � ������ ? | �����: 90')

			imgui.Text(u8'89)������� ����� ������������� ������� � ����������� � ���� ? | �����: 1000000')

			imgui.Text(u8'90)������� ����� ��������� "�������" ��� �����? | �����: 50000000')

			imgui.Text(u8'91) ����� ������������ ����� ����� ����� ���������� � ���������� �����? | �����: 1800000')

			imgui.Text(u8'92) ������ ��������� ������ �� ��������� �������� ������? | �����: 4000000')

			imgui.Text(u8'93) �� ����� ���������� �������� ��������� ����� �������� 1 �������� �����? | �����: 5')

			imgui.Text(u8'94) ������� ���� �������� 14 ������� Winslow � ������� xx.xx.xx | �����: 04.11.20')

			imgui.Text(u8'95) ����� ������� ������� ��������� ��� ���� ����� �������� �� ������ ������ ? | �����: 6')

			imgui.Text(u8'96) ������� ���������� ����� � ����� Sundet Marquis Hotel | �����: 4')

			imgui.Text(u8'97) ������� ��������� ��������� "���" � ������ ���� | �����: 50000')

			imgui.Text(u8'98) ������� ����� ��������� ����� ������� �������� �� ����������? | �����: 300')

			imgui.Text(u8'99) ������� ����� 1 ��� ������ �������� ������� | �����: 10000')

			imgui.Text(u8'100) ������� ���� �������� 11 ������� Prescott � ������� xx.xx.xx | �����: 05.01.20')

			imgui.Text(u8'101) ������� �������� ����� �������� ������� ����� �� ������� �� �� �������� ? | �����: 20')

			imgui.Text(u8'102) ������� ����� 1 AZ-Coins � �������� ? | �����: 50000')

			imgui.Text(u8'103) ��� ���������� ����������� �� ������� ����� �������� ���� ? | �����: ����������')

			imgui.End()
	end
end