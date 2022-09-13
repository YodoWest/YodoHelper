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
				sampAddChatMessage('Есть Обновление скрипта!', 0xFFFFFF)
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
					sampAddChatMessage('Скрипт Обновлён!', 0xFFFFFF)
					thisScript():reload()
				end
			end)
			break
		end
	end
end

function cmd_update(arg)
    sampShowDialog(1000, "Автообновление! v1.0", "{FFFFFF}Обновлений нету", "Закрыть", "", 0)
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

			imgui.Begin(u8'Ответы на клады', main_window_state)

			local filterBuf = imgui.ImBuffer('', 360)
			local text =
			{
				u8'1)Укажите дату открытия 7 сервера Mesa в формате xx.xx.xx | Ответ: 06.01.18',
				'Apply',
				'Phone'
			}

			if imgui.CollapsingHeader(u8'Поиск') then
				imgui.InputText('Filter', filterBuf)
				if filterBuf.v:len() ~= 0 then
					for i = 1, #text do
						if string.find(text[i], filterBuf.v) then
							imgui.Text(text[i])
						end
					end
				end
			end

			imgui.Text(u8'1)Укажите дату открытия 7 сервера Mesa в формате xx.xx.xx | Ответ: 06.01.18')

			imgui.Text(u8'2)Укажите дату открытия 8 сервера Red-Rock в формате xx.xx.xx | Ответ: 26.07.18')

			imgui.Text(u8'3)Укажите дату открытия 9 сервера Yuma в формате xx.xx.xx | Ответ: 06.01.19')

			imgui.Text(u8'4)Укажите дату открытия 12 сервера Glendale в формате xx.xx.xx | Ответ: 01.04.20')

			imgui.Text(u8'5)Укажите дату открытия 13 сервера Kingman в формате xx.xx.xx | Ответ: 28.04.20')

			imgui.Text(u8'6)Укажите дату открытия 15 сервера Payson в формате xx.xx.xx | Ответ: 04.01.21')

			imgui.Text(u8'7)Укажите дату открытия 16 сервера Gilbert в формате xx.xx.xx | Ответ: 09.05.21')

			imgui.Text(u8'8)Как зовут старшего менеджера стоящего на аукционе контейнеров? | Ответ: Магнус')

			imgui.Text(u8'9)Как зовут квест персонажа стоящего у тренировочного полигона автошколы ? | Ответ: Маргарита')

			imgui.Text(u8'10)Как зовут скупщика нелегала в гетто ? | Ответ: Гурам')

			imgui.Text(u8'11)Какой игровой уровень требуется для того чтобы устроить на работу адвоката ? | Ответ: 7')

			imgui.Text(u8'12)Какой игровой уровень требуется для того чтобы устроить на работу инкассатора ? | Ответ: 6')

			imgui.Text(u8'13)Какой порядковый номер у бизнеса "Информационный центр"? | Ответ: 212')

			imgui.Text(u8'14)Какой порядковый номер у бизнеса отель-пирамида ? | Ответ: 144')

			imgui.Text(u8'15)Какой порядковый номер у бизнеса "Автобазар" | Ответ: 126')

			imgui.Text(u8'16)Укажите количество ячеек у фермы №2 |Ответ: 42')

			imgui.Text(u8'17)Укажите количество ячеек у фермы №3 | Ответ: 46')

			imgui.Text(u8'18)Укажите количество ячеек у фермы №5 | Ответ: 61')

			imgui.Text(u8'19)Укажите сколько семейных монет стоит предмет "Маска робота" в семейном магазине ? | Ответ: 2900')

			imgui.Text(u8'20)Какова гос стоимость самой дорогой яхты? | Ответ: 25600000')

			imgui.Text(u8'21)Сколько стоит вызвать такси через телефонную будку ? | Ответ: 400')

			imgui.Text(u8'22)Вопрос : Сколько всего семейных территорий | Ответ: 156')

			imgui.Text(u8'23)Максимальный этаж в ЖК Los Santos Tower ? | Ответ: 13')

			imgui.Text(u8'24)Вопрос: Сколько стоит билет на мероприятие "Собиратели"? | Ответ: 30000')

			imgui.Text(u8'25)Вопрос: Укажите количество нефтевышек доступных на сервере | Ответ: 8')

			imgui.Text(u8'26)Вопрос : Сколько стоит кирка для добычи ископаемых которую продает Лари ? | Ответ: 5000')

			imgui.Text(u8'27)В каком году была добавлена "Лихорадка" на проект ? | Ответ: 2017')

			imgui.Text(u8'28)Какая максимальная сумма штрафа может быть наложена на личный автомобиль ? | Ответ: 80000')

			imgui.Text(u8'29)Укажите сколько семейных монет стоит предмет "Реактивный ранец" в семейном магазине ? | Ответ: 2400')

			imgui.Text(u8'30) Какая гос. цена бизнеса - сельскохозяйственный магазин? | Ответ: 45000000')

			imgui.Text(u8'31)Сколько авто стоит в пожарной части Лос Сантоса ? | Ответ: 5')

			imgui.Text(u8'32)Ник первого Спец. Администратора проекта? | Ответ: Sweеt_Jonson')

			imgui.Text(u8'33)Сколько стоит стоит улучшение "Бренд" для семьи? | Ответ: 80000000')

			imgui.Text(u8'34)Сколько стоят обручальные кольца для проведения свадьбы? | Ответ: 5000')

			imgui.Text(u8'35)Сколько всего нелегальных автомобилей доступно к покупке в автосалоне ? | Ответ: 14')

			imgui.Text(u8'36)Начальная ставка в контейнерах | Ответ: 4000000')

			imgui.Text(u8'37)Какая фамилия у разработчика Евгения ? | Ответ: Косовский')

			imgui.Text(u8'38)Как зовут квест персонажа стоящего в Больнице ЛС ? | Ответ: Керри')

			imgui.Text(u8'39)Сколько всего автобусов припарковано на ЖД ЛВ ? | Ответ: 7')

			imgui.Text(u8'40)Минимальная ставка за Premium контейнер | Ответ: 15000000')

			imgui.Text(u8'41)Какая гос. цена бизнеса "нефтевышка" ? | Ответ: 60000000')

			imgui.Text(u8'42)В честь какого разработчика стоит статуя на ЖД ЛС ? | Ответ: Калькор')

			imgui.Text(u8'43)Сколько стоит лотерейный VIP-билет? | Ответ: 2500000')

			imgui.Text(u8'44)Какое количество авто можно иметь купив PREMIUM VIP ? | Ответ: 20')

			imgui.Text(u8'45)Сколько стоит покупка прав на полёты ? | Ответ: 200000')

			imgui.Text(u8'46)Какова гос. стоимость самой дешевой фермы ? | Ответ: 50000000')

			imgui.Text(u8'47)На каком мероприятии можно в костюме попугая собирать яйца ? | Ответ: Собиратели')

			imgui.Text(u8'48) Укажите номер справочной центрального банка | Ответ: 8828')

			imgui.Text(u8'49)Сколько стоит совершить прыжок с парашютом? | Ответ: 900')

			imgui.Text(u8'50)Как назывался город, который когда то был построен, а затем снесен? | Ответ: NewIsland')

			imgui.Text(u8'51)Сколько всего личных ферм на сервере ? | Ответ: 5')

			imgui.Text(u8'52)Укажите количество ячеек у фермы №1 | Ответ: 24')

			imgui.Text(u8'53)Укажите точное количество магазинов видеокарт | Ответ: 3')

			imgui.Text(u8'54)Какова гос. стоимость трейлера среднего класса | Ответ: 3500000')

			imgui.Text(u8'55)Укажите сколько дрифт монет стоит предмет "Крылья зеленые" в сувенирной лавке ? | Ответ: 1300')

			imgui.Text(u8'56)Укажите сколько семейных монет стоит предмет "Рюкзак будущего" в семейном магазине ? | Ответ: 2800')

			imgui.Text(u8'57)На какой номер нужно позвонить чтобы вызвать такси ? | Ответ: 913')

			imgui.Text(u8'58)Какова начальная ставка на контейнер класса ультра ? | Ответ: 20000000')

			imgui.Text(u8'59)Сколько стоит проход в VIP зал казино ? | Ответ: 50000')

			imgui.Text(u8'60)Максимальная сумма пожертвования в благотворительность ? | Ответ: 100000000')

			imgui.Text(u8'61)Как зовут персонажа который всегда встречает новых игроков на вокзале ? | Ответ: Джереми')

			imgui.Text(u8'62)Какой игровой уровень нужно достигнуть чтобы создать свою семью ? | Ответ: 20')

			imgui.Text(u8'63)На какой номер нужно позвонить чтобы вызвать механика ? | Ответ: 914')

			imgui.Text(u8'64)Укажите дату открытия 10 сервера Surprise в формате xx.xx.xx | Ответ: 25.07.19')

			imgui.Text(u8'65)Имя первого владельца проекта Arizona RP ? | Ответ: Денис')

			imgui.Text(u8'66)Какой порядковый номер у бизнеса "Аренда велосипедов" | Ответ: 215')

			imgui.Text(u8'67)На какой номер нужно позвонить чтобы вызвать скорую помощь ? | Ответ: 912')

			imgui.Text(u8'68)Сколько стоит создание новой семьи ? | Ответ: 20000000')

			imgui.Text(u8'69)Какой игровой уровень требуется для того чтобы устроить на работу водителя трамвая ? | Ответ: 9')

			imgui.Text(u8'70)Какой игровой уровень требуется для того чтобы устроить на работу крупье ? | Ответ: 5')

			imgui.Text(u8'71)Сколько всего авто доступно у станции дорожной службы ? | Ответ: 5')

			imgui.Text(u8'72)Какой игровой уровень требуется для того чтобы устроить на работу дальнобойщика ? | Ответ: 5')

			imgui.Text(u8'73)Какой игровой уровень требуется для того чтобы устроить на работу ремонтника дорог ? | Ответ: 10')

			imgui.Text(u8'74)Какое количество прицепов доступно для работы дальнобойщиком на станции около Форт Карсона? | Ответ:6')

			imgui.Text(u8'75)Какая нужна сумма для того чтобы отреставрировать здание на улице ? | Ответ: 1500000000')

			imgui.Text(u8'76)Как зовут персонажа который проводит мгновенную лотерею на центральном рынке ? | Ответ: Милтон')

			imgui.Text(u8'77)Укажите сколько дрифт монет стоит предмет "Паук" В сувенирной лавке? | Ответ: 600')

			imgui.Text(u8'78)Какой игровой уровень требуется для того чтобы устроить на работу механика? | Ответ: 3')

			imgui.Text(u8'79)Укажите сколько дрифт монет стоит предмет "Корона" в сувенирной лавке? | Ответ: 1000')

			imgui.Text(u8'80)Сколько семейных монет начисляется на баланс фам. территории каждый PayDay ? | Ответ: 8')

			imgui.Text(u8'81)Укажите минимальную сумму для раздачи в центре занятости | Ответ: 10000')

			imgui.Text(u8'82)Как зовут ту, которая постоянно готова сыграть с вами в кости ? | Ответ: Оливия')

			imgui.Text(u8'83)Стоимость аренды лавки №8 на центральном рынке ? | Ответ: 100000')

			imgui.Text(u8'84)Укажите дату открытия 6 сервера Saint Rose в формате xx.xx.xx | Ответ: 27.08.17')

			imgui.Text(u8'85)Как зовут персонажа который стоит под мостом рядом с базой банды Ballas ? | Ответ: Иван Гай')

			imgui.Text(u8'86)Укажите количество ячеек у фермы №4 | Ответ: 35')

			imgui.Text(u8'87)Сколько разработчиков работают над обновлениями на проекте ? | Ответ: 3')

			imgui.Text(u8'88)Какова стоимость 1 фишки в казино ? | Ответ: 90')

			imgui.Text(u8'89)Сколько стоит строительство подвала с вентиляцией в доме ? | Ответ: 1000000')

			imgui.Text(u8'90)Сколько стоит улучшение "Галочка" для семьи? | Ответ: 50000000')

			imgui.Text(u8'91) Какую максимальную сумму денег можно перевозить в грузовиках мафии? | Ответ: 1800000')

			imgui.Text(u8'92) Какова начальная ставка на контейнер обычного класса? | Ответ: 4000000')

			imgui.Text(u8'93) На какое количество семейной репутации можно обменять 1 семейный талон? | Ответ: 5')

			imgui.Text(u8'94) Укажите дату открытия 14 сервера Winslow в формате xx.xx.xx | Ответ: 04.11.20')

			imgui.Text(u8'95) Какой игровой уровень требуется для того чтобы устроить на работу пилота ? | Ответ: 6')

			imgui.Text(u8'96) Укажите количество звезд у отеля Sundet Marquis Hotel | Ответ: 4')

			imgui.Text(u8'97) Укажите стоимость улучшения "бар" В личном доме | Ответ: 50000')

			imgui.Text(u8'98) Сколько нужно заплатить чтобы открыть шлагбаум на автобазаре? | Ответ: 300')

			imgui.Text(u8'99) Сколько стоит 1 час аренды уличного баннера | Ответ: 10000')

			imgui.Text(u8'100) Укажите дату открытия 11 сервера Prescott в формате xx.xx.xx | Ответ: 05.01.20')

			imgui.Text(u8'101) Сколько подарков нужно принести Эдварду чтобы он обменял их на шкатулку ? | Ответ: 20')

			imgui.Text(u8'102) Сколько стоит 1 AZ-Coins у Абрахама ? | Ответ: 50000')

			imgui.Text(u8'103) Как называется мероприятие на котором нужно собирать яйца ? | Ответ: Собиратели')

			imgui.End()
	end
end