-------------------------------------------------------------------------
-- FileName		:	posthouse.lua
-- Author		:	xiaoyang
-- CreateTime	:	2005-04-04 15:30:14
-- Desc			:	����������ٽű�
-------------------------------------------------------------------------
Include("\\script\\task\\newtask\\newtask_head.lua")
Include("\\script\\task\\tollgate\\messenger\\messenger_timeer.lua")    --���ü�ʱ��
Include("\\script\\task\\tollgate\\messenger\\messenger_losetask.lua")  --ȡ������
Include("\\script\\task\\task_addplayerexp.lua")  --������ۼӾ���Ĺ�������
Include("\\script\\task\\tollgate\\killbosshead.lua") --������ͼ�����
Include("\\script\\activitysys\\g_activity.lua")
Include("\\script\\task\\tollgate\\messenger\\qianbaoku\\messenger_baoxiangtask.lua")--�����乤�ߺ���
Include("\\script\\activitysys\\playerfunlib.lua")
Include("\\script\\lib\\log.lua")
IncludeLib("RELAYLADDER");	--���а�

citygo = {
--�ɶ�ȥ��������(mapid:11)
{1204,1,"Th�nh ��","��i L�",1203,11,162,1674,3132},

--����ȥ��������(mapid:162)
{1204,2,"��i L�","Th�nh ��",1203,162,11,3021,5090},

}

-------------------------------------------������ʹ�����������-------------------------------------------------
function especiallymessenger()
	local _, _, nMapIndex = GetPos()
	local MapId = SubWorldIdx2ID( nMapIndex )
	if MapId ~= 11 and MapId ~= 162 then
		Talk(1,"","Tham gia nhi�m v� T�n S� h�y �i t�m D�ch Quan <color=red>Th�nh ��<color> ho�c <color=red> ��i L�<color>!")
		return
	end
	
	nt_setTask(1211,0)
	Describe(DescLink_YiGuan..": Vi�c qu�n c� c�a Tri�u ��nh g�n ��y lu�n b� gi�c Kim bi�t tr��c, ta nghi ng� c� n�i gi�n. Nh�ng tr��c khi m�y t�n b�i lo�i n�y b� ph�t hi�n, ta mu�n r�ng tin n�y kh�p n�i ��u bi�t, ng��i c� mu�n g�p m�t ph�n s�c cho Qu�c gia kh�ng?",7,
	"Ta b�ng l�ng!/messenger_ido",
	"Ta ��n �� giao nhi�m v� T�n s� /messenger_finishtask",
	"Ta mu�n x�a b� nhi�m v� T�n s� /messenger_losemytask",
	"Ta mu�n bi�t v� nhi�m v� T�n s�!/messenger_what",
	"G�n ��y ta c� nhi�u chuy�n c�n l�m!/no")
end


-------------------------------------------����������ʹ�����������-----------------------------------------------


function messenger_ido()
	local _, _, nMapIndex = GetPos()
	
	local Uworld1204 = nt_getTask(1204)  --��¼��ҵ����������ÿ���������ʱ���
	local Uworld1028 = nt_getTask(1028)  --�������������
	local MapId = SubWorldIdx2ID( nMapIndex )
	-- if ( GetLevel() < 120 ) then
	if ( GetLevel() < 80 ) then
		-- Describe(DescLink_YiGuan..": Xin l��ng th�, ��ng c�p c�a ng��i hi�n t�i ch�a �� 120. h�y ti�p t�c t�i luy�n r�i ��n g�p ta.",1,"K�t th�c ��i tho�i/no")	
		Describe(DescLink_YiGuan..": Xin l��ng th�, ��ng c�p c�a ng��i hi�n t�i ch�a �� 80. h�y ti�p t�c t�i luy�n r�i ��n g�p ta.",1,"K�t th�c ��i tho�i/no")	
	elseif ( Uworld1204 ~= 0 )  then
		Describe(DescLink_YiGuan..":Xin l�i! Nhi�m v� T�n s� c�a b�n ch�a ho�n th�nh, kh�ng th� ti�p nh�n nhi�m v� gi�ng nhau, xin ho�n th�nh nhi�m v� n�y tr��c, c�m �n!",1,"K�t th�c ��i tho�i/no")
	else
    	local nTaskFlag = check_daily_task_count()--��黹��û���������
    	if nTaskFlag == 0 then
    		Describe(DescLink_YiGuan..": Xin l��ng th�, H�m nay ng��i �� v�t v� r�i. Ng�y mai h�y quay l�i nh�.",1,"K�t th�c ��i tho�i/no")
    		return
    	elseif nTaskFlag == -1 then
    		Describe(DescLink_YiGuan..": H�m nay ng��i �� m�t m�i r�i. N�u ng��i c� <color=yellow>Thi�n Kh� B�o L�nh<color>, ta s� ph� l� cho ng��i tham gia th�m m�t l�n n�a.",1,"K�t th�c ��i tho�i/no")
    		return
    	elseif nTaskFlag == 2 then
    		Msg2Player("Ng��i c� c�m Thi�n Kh� B�o L�nh tham gia nhi�m v�, <color=yellow>nhi�m v� ho�n th�nh<color> ta s� thu h�i L�nh B�i")
    	end
    	
    	WriteLog(format("Account:%s[Name:%s] ti�p nh�n nhi�m v� T�n S�, h�m nay �� ho�n th�nh [%d] l�n.",
				GetAccount(),
				GetName(),
				nTaskFlag
				)
			);
	if nTaskFlag == 2 then
		tbLog:PlayerActionLog("TinhNangKey","NhanNhiemVuTinSuSuDungThienBaoKhoLenh")		
	else
		tbLog:PlayerActionLog("TinhNangKey","NhanNhiemVuTinSu")
	end
		
		if ( MapId == 11 ) then
			if ( messenger_choice(1,1) ~= 10 ) then
					print("messenger_choice error:1")
			end
		elseif ( MapId == 162 ) then
			if ( messenger_choice(2,2) ~= 10 ) then
					print("messenger_choice error:2")
			end
		else
			Msg2Player("Xin l�i! Kh�ng bi�t t�i sao b�n l�i kh�ng th� nh�n nhi�m v� T�n s�? Xin li�n h� v�i GM!")
		end
	end
end

function messenger_storewagoner()
	SetRevPos(11,10)
	
	NewWorld(395,1417,3207)
end

-----------------------------------------------������Ҫ������һ��������ʹ���񣬲��ı�����ʹ��������͵���ؿ�����------------------------
function messenger_choice(CityIdTwo,j)
	if ( CityIdTwo == citygo[j][2] ) then	
		--�����ɴ˵�ȥ�˵ص��������	
		nt_setTask( 1204,citygo[j][2] )
		--����ȥ���ĸ��ؿ����������   
		nt_setTask( citygo[j][5],10) --������ʹ����Ĳ���
		local name = GetName()
		Talk(1,"","B�n nh�n ���c t� "..citygo[j][3].."��n"..citygo[j][4].."c�a nhi�m v� T�n s� ��c bi�t,"..citygo[j][3].."D�ch tr�m D�ch quan cung t�ng"..name.."��i nh�n!")		
		return 10
	end
end


---------------------------------------------------������ʹ�ƺ�----------------------------------------------------------------------

function messenger_levelmu()
	local Uworld1205 = nt_getTask(1205)
	local Uworld1206 = nt_getTask(1206)
	local name = GetName()
	if ( Uworld1205 >= 50 ) then
		if ( Uworld1206 < 1 ) then
			nt_setTask(1206,1)
			nt_setTask(1205,Uworld1205-50)
			Describe(DescLink_YiGuan..": Ch�c m�ng"..name.."��i nh�n tr� th�nh T�n s� M�c!",1,"K�t th�c ��i tho�i/no")
		elseif ( Uworld1206 == 1 ) then
			Describe(DescLink_YiGuan..":"..name.."! B�n �� l� T�n s� - M�c, kh�ng c�n t�ng c�p, xin h�y c� g�ng!",1,"K�t th�c ��i tho�i/no")		
		else
			Describe(DescLink_YiGuan..":"..name.."! ��ng c�p c�a b�n v��t qu� T�n s� - M�c, xin h�y ch�n T�n s� kh�c.",2,"Quay l�i/messenger_getlevel","K�t th�c ��i tho�i/no")				
		end
	else
		Describe(DescLink_YiGuan..":Xin l�i!  B�n kh�ng ph� h�p v�i �i�u ki�n t�ng c�p c�a T�n s� - M�c, xin h�y n� l�c, c�m �n!",2,"Quay l�i/messenger_getlevel","K�t th�c ��i tho�i/no")
	end
end

function messenger_leveltong()
	local Uworld1205 = nt_getTask(1205)
	local Uworld1206 = nt_getTask(1206)
	local name = GetName()
	if ( Uworld1205 >= 150 )  then
		if ( Uworld1206 < 2 ) then
			nt_setTask(1206,2)
			nt_setTask(1205,Uworld1205-150)
			Describe(DescLink_YiGuan..": Ch�c m�ng"..name.."��i nh�n th�ng th�nh T�n s� - ��ng!",1,"K�t th�c ��i tho�i/no")
		elseif ( Uworld1206 == 2 ) then
			Describe(DescLink_YiGuan..":"..name.."! Ban �� l� T�n s� - ��ng, kh�ng c�n t�ng c�p n�a, xin h�y ti�p t�c n� l�c!",1,"K�t th�c ��i tho�i/no")				
		else
			Describe(DescLink_YiGuan..":"..name.."! ��ng c�p c�a b�n �� v��t qu� T�n s�-��ng, xin h�y ch�n T�n s� kh�c.",2,"Quay l�i/messenger_getlevel","K�t th�c ��i tho�i/no")				
		end
	else
		Describe(DescLink_YiGuan..":Xin l�i!  ��ng c�p c�a b�n kh�ng ph� h�p �i�u ki�n t�ng c�p c�a T�n s� - ��ng, xin h�y ti�p t�c n� l�c, c�m �n!",2,"Quay l�i/messenger_getlevel","K�t th�c ��i tho�i/no")
	end
end

function messenger_levelyin()
	local Uworld1205 = nt_getTask(1205)
	local Uworld1206 = nt_getTask(1206)
	local name = GetName()
	if ( Uworld1205 >= 450 ) then
		if ( Uworld1206 < 3 ) then
			nt_setTask(1206,3)
			nt_setTask(1205,Uworld1205-450)
			Describe(DescLink_YiGuan..": Ch�c m�ng"..name.."��i nh�n th�ng th�nh T�n s� - B�c!",1,"K�t th�c ��i tho�i/no")
		elseif ( Uworld1206 == 3 ) then
			Describe(DescLink_YiGuan..":"..name.."! B�n �� l� T�n s� - B�c, kh�ng c�n th�ng c�p, h�y ti�p t�c c� g�ng!",1,"K�t th�c ��i tho�i/no")				
		else
			Describe(DescLink_YiGuan..":"..name.."! ��ng c�p c�a b�n �� v��t qua T�n S� - B�c, xin h�y ch�n T�n s� kh�c!",2,"Quay l�i/messenger_getlevel","K�t th�c ��i tho�i/no")				
		end
	else
		Describe(DescLink_YiGuan..":Xin l�i!  B�n kh�ng ph� h�p v�i �i�u ki�n th�ng c�p c�a T�n s� - B�c, xin b�n h�y ti�p t�c c� g�ng, c�m �n!",2,"Quay l�i/messenger_getlevel","K�t th�c ��i tho�i/no")
	end
end

function messenger_leveljin()
	local Uworld1205 = nt_getTask(1205)
	local Uworld1206 = nt_getTask(1206)
	local name = GetName()
	if ( Uworld1205 >= 800 ) then
		if ( Uworld1206 < 4 ) then
			nt_setTask(1206,4)
			nt_setTask(1205,Uworld1205-800)
			Describe(DescLink_YiGuan..": Ch�c m�ng"..name.."��i nh�n th�ng th�nh T�n s� - V�ng!",1,"K�t th�c ��i tho�i/no")
		elseif ( Uworld1206 == 4 ) then
			Describe(DescLink_YiGuan..":"..name.."! B�n �� l� T�n s� - V�ng, kh�ng c�n t�ng c�p n�a, h�y ti�p t�c c� g�ng!",1,"K�t th�c ��i tho�i/no")		
		else
			Describe(DescLink_YiGuan..":"..name.."! ��ng c�p c�a b�n �� v��t qu� T�n s� - V�ng, xin ch�n T�n s� kh�c!",2,"Quay l�i/messenger_getlevel","K�t th�c ��i tho�i/no")				
		end
	else
		Describe(DescLink_YiGuan..":Xin l�i!  B�n kh�ng ph� h�p v�i �i�u ki�n th�ng c�p c�a T�n s� - V�ng, h�y ti�p t�c c� g�ng, c�m �n!",2,"Quay l�i/messenger_getlevel","K�t th�c ��i tho�i/no")
	end
end

function messenger_levelyuci()
	local Uworld1205 = nt_getTask(1205)
	local Uworld1206 = nt_getTask(1206)
	local name = GetName()
	if ( Uworld1205 >= 1500 ) then
		if ( Uworld1206 < 5 ) then
			nt_setTask(1206,5)
			nt_setTask(1205,Uworld1205-1500)
			Describe(DescLink_YiGuan..": Ch�c m�ng"..name.."��i nh�n th�ng th�nh Ng� T� T�n s� y�u b�i!",1,"K�t th�c ��i tho�i/no")
		elseif ( Uworld1206 == 5 ) then
			Describe(DescLink_YiGuan..":"..name.."B�n �� l� Ng� T� T�n s� - V�ng, kh�ng c�n t�ng c�p n�a, xin h�y ti�p t�c c� g�ng!",1,"K�t th�c ��i tho�i/no")				
		end
	else
		Describe(DescLink_YiGuan..":Xin l�i! B�n kh�ng ph� h�p �i�u ki�n v�i �i�u ki�n t�ng c�p c�a Ng� T� T�n s� - V�ng, xin h�y ti�p t�c c� g�ng, c�m �n!",2,"Quay l�i/messenger_getlevel","K�t th�c ��i tho�i/no")
	end
end

--------------------------------------------����ʹ����------------------------------------------------------
function messenger_finishtask()
	local Uworld1201= nt_getTask(1201)	--���������֮���������
	local Uworld1202= nt_getTask(1202)	--��������ɽ�����������
	local Uworld1203= nt_getTask(1203)	--��������ǧ�����������
	local Uworld1204= nt_getTask(1204)	--�������������ص��������
	local Uworld1218= nt_getTask(1218)  --��ʹ������ɴ���������

	if ( Uworld1203 == 30 or Uworld1203 == 25 ) then
		if ( messenger_gettime() == 10 ) then
			Describe(DescLink_YiGuan..":Xin l�i!  B�n ch�a ho�n th�nh nhi�m v� m� h�m tr��c ��n l�nh th��ng, nhi�m v� n�y coi nh� �� th�t b�i r�i!",1,"K�t th�c ��i tho�i/no")
		else
			nt_setTask(1218,Uworld1218+1)
			Describe(DescLink_YiGuan..":  Ch�c m�ng b�n �� ho�n th�nh nhi�m v�!",1,"Nh�n l�nh ph�n th��ng/messenger_treasureprize")
		end
	elseif Uworld1203 ~= 0 then
		Describe(DescLink_YiGuan..": Xin h�y l��ng th�, ng��i v�n ch�a ho�n th�nh nhi�m v� hi�n t�i. L�o Xa Phu b�n c�nh ta c� th� ��a ng��i ��n b�n �� nhi�m v� !",1,"K�t th�c ��i tho�i/no")
	else
		Describe(DescLink_YiGuan..": Ch�a ti�p nh�n nhi�m v� n�o ng��i c�n l�i tr� nhi�m v�! Ng��i ��u? B�m c�i t�n n�y l�m nh�n b�nh bao cho ta!",1,"K�t th�c ��i tho�i/no")
	end
end

function messenger_flyprize()
end

function messenger_templeprize()
end

function messenger_treasureprize()
  local nTaskFlag = check_daily_task_count()--��黹��û���������
  if nTaskFlag == 0 then
  	Describe(DescLink_YiGuan..": Xin h�y l��ng th�, h�m nay ng��i �� qu� m�t r�i. Hay l� ng�y mai l�i ��n ��i nhi�m v� nh�.",1,"K�t th�c ��i tho�i/no")
  	return
  elseif nTaskFlag == -1 then
  	Describe(DescLink_YiGuan..": C� ph�i ng��i �� l�y <color=yellow> Thi�n Kh� B�o L�nh <color> l�m m�t r�i h�? T�m L�nh B�i v� ��y ta m�i th��ng cho ng��i.",1,"K�t th�c ��i tho�i/no")
  	return
  end
  
  --��鱳���ռ�
  local nTodayTaskCount = %get_task_daily(1205)
  local nBagCellNeed = 1
  if nTodayTaskCount == 0 then
  	nBagCellNeed = 2
  end
  if (CalcFreeItemCellCount() < nBagCellNeed) then
		Talk(1, "", format("<#>H�nh trang c�a ng��i kh�ng �� ch� tr�ng, h�y s�p x�p l�i h�nh trang c�n tr�ng %d � r�i h�y ��n nh�n th��ng nh�.",nBagCellNeed))
		return
	end
	local n_level = GetLevel();
	G_ACTIVITY:OnMessage("FinishMail", 1, n_level);	
	--�۳�ǧ������
	if nTaskFlag == 2 then
	--Fix bug kh�ng tr� ���c thi�n b�o kh� l�nh trong r��ng bang h�i - Modifiec by DinhHQ - 20110502
	    	if ConsumeEquiproomItem(1, 6, 1, 2813, -1) == 1 then--�۳�ǧ������
	    		Msg2Player("Ng��i �� giao 1 Thi�n B�o Kh� L�nh")
	    	else
	    		Talk(1, "", "Thi�n B�o Kh� L�nh c�a ng��i ��u sao ta kh�ng th�y?")
	    		return
	    	end
    end
    
   	%add_task_daily(1205, 1)
	nt_setTask(1201,0)	--
	nt_setTask(1202,0)
	nt_setTask(1203,0)
	nt_setTask(1204,0)
	
	nTodayTaskCount = %get_task_daily(1205)--��ȡ�������ļ���ֵ
	WriteLog(format("Account:%s[Name:%s] nh�n ph�n th��ng nhi�m v� T�n S�, h�m nay �� ho�n th�nh [%d] l�n.",
			GetAccount(),
			GetName(),
			nTodayTaskCount
			)
		);
		
	--ÿ���һ�����������3��������
	if nTodayTaskCount == 1 then
		-- for i = 1, 3 do
			--Fix bug sai level h�nh hi�p l�nh - Modified by DinhHQ - 20110921
			-- AddItem(6,1,2566,1,0,0)--��ȡ��������Ϊ����״̬
		-- end;
		Msg2Player("Ng��i nh�n ���c 3 H�nh Hi�p L�nh")
	end
	
	--ÿ�ν�������2����ʹ����
	for i = 1, 2 do
		AddItem(6,1,2812,0,0,0)
	end;
	Msg2Player("Ng��i nh�n ���c 2 T�n S� B�o R��ng")
end

function messenger_simpleprize()

		
end

--------------------------------------------���ֻ�����-----------------------------------------------------
function messenger_duihuanprize()
	Describe(DescLink_YiGuan..": Ph�n th��ng g�m c�: T�n s� y�u b�i v� Trang b� Ho�ng Kim. Y�u b�i c� th� t�ng kh�ng t�nh c�a nh�n v�t, trang b� Ho�ng Kim c� th� t�ng kinh nghi�m. B�n mu�n ch�n lo�i n�o?",3,
		"T�n s� y�u b�i /messenger_prize_yaopai",
		"Trang b� Ho�ng Kim/messenger_prize_huangjin",
--		"ͬ�����/messenger_prize_partner",
--		"������Ʒ/messenger_prize_other",
		"Sau n�y h�y n�i!/no")
end

function messenger_prize_partner()
	Describe(DescLink_YiGuan..": Th� l�nh Long ng� v�a m�i mang v� m�t s� <color=red>M�t n� ��ng h�nh k� b�<color>, ng��i c� mu�n d�ng th� kh�ng?",5,
		"K� n�ng ��ng h�nh/no",
		"M�t n� ��ng h�nh/messenger_prize_mianju",
		"V�t ph�m ��ng h�nh/no",
		"Quay l�i/messenger_duihuanprize",
		"Sau n�y h�y n�i!/no")
end

function messenger_prize_mianju()
	Describe(DescLink_YiGuan..": M�t n� ��ng h�nh chia th�nh 2 lo�i: 1 l�n s� dung v� 10 l�n s� d�ng.  Mu�n ��i c�i n�o?",4,
	"��i M�t n� 1 l�n/prize_mianju_dan",
	"��i M�t n� 10 l�n/prize_mianju_shi",
	"Quay l�i/messenger_prize_partner",
	"T�m th�i kh�ng ��i ���c!/no")
end

function prize_mianju_shi()
	Describe(DescLink_YiGuan..": B�n mu�n ��i M�t n� (10 l�n) Thi�u Ni�n V� s� L�i Ki�m hay l� Thanh Ni�n V� s� L�i Ki�m?  Xem r� ch�a ch�a?",4,
	"��i M�t n� Thi�u Ni�n V� S� /prize_mianju_shi_shaonian",
	"��i M�t n� Thanh Ni�n V� /prize_mianju_shi_qingnian",
	"Quay l�i/messenger_prize_mianju",
	"T�m th�i kh�ng ��i ���c!/no")
end

function prize_mianju_shi_shaonian()
	Describe(DescLink_YiGuan..": B�t ��u ��i ��y!",7,
	"M�t n� (10 l�n) - Thi�u Ni�n L�i Ki�m [40000 ph�t]/prize_mianju_shi_shaolin_leijian",
	"M�t n� (10 l�n) - Thi�u Ni�n Ti�u S��ng [40000 ph�t]/prize_mianju_shi_shaolin_xiaoshuang",
	"M�t n� (10 l�n) - Thi�u Ni�n H�a Nh�n [40000 ph�t]/prize_mianju_shi_shaolin_huoren",
	"M�t n� (10 l�n) - Thi�u Ni�n H�i ���ng [40000 ph�t]/prize_mianju_shi_shaolin_haitang",
	"M�t n� (10 l�n) - Thi�u Ni�n Kim Phong [40000 ph�t]/prize_mianju_shi_shaolin_jinfeng",
	"Quay l�i/prize_mianju_shi",
	"T�m th�i kh�ng ��i ���c!/no")
end

function prize_mianju_shi_qingnian()
	Describe(DescLink_YiGuan..": B�t ��u ��i ��y!",7,
	"M�t n� (10 l�n) - Thanh Ni�n L�i Ki�m [40000 ph�t]/prize_mianju_shi_qinglin_leijian",
	"M�t n� (10 l�n) - Thanh Ni�n Ti�u S��ng [40000 ph�t]/prize_mianju_shi_qinglin_xiaoshuang",
	"M�t n� (10 l�n) - Thanh Ni�n H�a Nh�n [40000 ph�t]/prize_mianju_shi_qinglin_huoren",
	"M�t n� (10 l�n) - Thanh Ni�n H�i ���ng [40000 ph�t]/prize_mianju_shi_qinglin_haitang",
	"M�t n� (10 l�n) - Thanh Ni�n Kim Phong [40000 ph�t]/prize_mianju_shi_qinglin_jinfeng",
	"Quay l�i/prize_mianju_shi",
	"T�m th�i kh�ng ��i ���c!/no")
end

function prize_mianju_shi_qinglin_leijian()
	if ( nt_getTask(1205) >= 40000 ) then
		AddItem(0,11,112,0,0,0,0)
		local Uworld1205 = nt_getTask(1205) - 40000
		nt_setTask(1205,Uworld1205)
		Msg2Player("B�n nh�n ���c 1 M�t n� ��ng h�nh")
	else
		Describe(DescLink_YiGuan..": Xin l�i! �i�m t�ch l�y c�a b�n kh�ng ��.",1,"K�t th�c! /no")
	end 
end

function prize_mianju_shi_qinglin_xiaoshuang()
	if ( nt_getTask(1205) >= 40000 ) then
		AddItem(0,11,113,0,0,0,0)
		local Uworld1205 = nt_getTask(1205) - 40000
		nt_setTask(1205,Uworld1205)
		Msg2Player("B�n nh�n ���c 1 M�t n� ��ng h�nh")
	else
		Describe(DescLink_YiGuan..": Xin l�i! �i�m t�ch l�y c�a b�n kh�ng ��.",1,"K�t th�c! /no")
	end 
end

function prize_mianju_shi_qinglin_huoren()
	if ( nt_getTask(1205) >= 40000 ) then
		AddItem(0,11,114,0,0,0,0)
		local Uworld1205 = nt_getTask(1205) - 40000
		nt_setTask(1205,Uworld1205)
		Msg2Player("B�n nh�n ���c 1 M�t n� ��ng h�nh")
	else
		Describe(DescLink_YiGuan..": Xin l�i! �i�m t�ch l�y c�a b�n kh�ng ��.",1,"K�t th�c! /no")
	end 
end

function prize_mianju_shi_qinglin_haitang()
	if ( nt_getTask(1205) >= 40000 ) then
		AddItem(0,11,115,0,0,0,0)
		local Uworld1205 = nt_getTask(1205) - 40000
		nt_setTask(1205,Uworld1205)
		Msg2Player("B�n nh�n ���c 1 M�t n� ��ng h�nh")
	else
		Describe(DescLink_YiGuan..": Xin l�i! �i�m t�ch l�y c�a b�n kh�ng ��.",1,"K�t th�c! /no")
	end 
end

function prize_mianju_shi_qinglin_jinfeng()
	if ( nt_getTask(1205) >= 40000 ) then
		AddItem(0,11,116,0,0,0,0)
		local Uworld1205 = nt_getTask(1205) - 40000
		nt_setTask(1205,Uworld1205)
		Msg2Player("B�n nh�n ���c 1 M�t n� ��ng h�nh")
	else
		Describe(DescLink_YiGuan..": Xin l�i! �i�m t�ch l�y c�a b�n kh�ng ��.",1,"K�t th�c! /no")
	end 
end

function prize_mianju_shi_shaolin_leijian()
	if ( nt_getTask(1205) >= 40000 ) then
		AddItem(0,11,102,0,0,0,0)
		local Uworld1205 = nt_getTask(1205) - 40000
		nt_setTask(1205,Uworld1205)
		Msg2Player("B�n nh�n ���c 1 M�t n� ��ng h�nh")
	else
		Describe(DescLink_YiGuan..": Xin l�i! �i�m t�ch l�y c�a b�n kh�ng ��.",1,"K�t th�c! /no")
	end 
end

function prize_mianju_shi_shaolin_xiaoshuang()
	if ( nt_getTask(1205) >= 40000 ) then
		AddItem(0,11,103,0,0,0,0)
		local Uworld1205 = nt_getTask(1205) - 40000
		nt_setTask(1205,Uworld1205)
		Msg2Player("B�n nh�n ���c 1 M�t n� ��ng h�nh")
	else
		Describe(DescLink_YiGuan..": Xin l�i! �i�m t�ch l�y c�a b�n kh�ng ��.",1,"K�t th�c! /no")
	end 
end

function prize_mianju_shi_shaolin_huoren()
	if ( nt_getTask(1205) >= 40000 ) then
		AddItem(0,11,104,0,0,0,0)
		local Uworld1205 = nt_getTask(1205) - 40000
		nt_setTask(1205,Uworld1205)
		Msg2Player("B�n nh�n ���c 1 M�t n� ��ng h�nh")
	else
		Describe(DescLink_YiGuan..": Xin l�i! �i�m t�ch l�y c�a b�n kh�ng ��.",1,"K�t th�c! /no")
	end 
end

function prize_mianju_shi_shaolin_haitang()
	if ( nt_getTask(1205) >= 40000 ) then
		AddItem(0,11,105,0,0,0,0)
		local Uworld1205 = nt_getTask(1205) - 40000
		nt_setTask(1205,Uworld1205)
		Msg2Player("B�n nh�n ���c 1 M�t n� ��ng h�nh")
	else
		Describe(DescLink_YiGuan..": Xin l�i! �i�m t�ch l�y c�a b�n kh�ng ��.",1,"K�t th�c! /no")
	end 
end

function prize_mianju_shi_shaolin_jinfeng()
	if ( nt_getTask(1205) >= 40000 ) then
		AddItem(0,11,106,0,0,0,0)
		local Uworld1205 = nt_getTask(1205) - 40000
		nt_setTask(1205,Uworld1205)
		Msg2Player("B�n nh�n ���c 1 M�t n� ��ng h�nh")
	else
		Describe(DescLink_YiGuan..": Xin l�i! �i�m t�ch l�y c�a b�n kh�ng ��.",1,"K�t th�c! /no")
	end 
end

function prize_mianju_dan()
	Describe(DescLink_YiGuan..": B�n mu�n ��i M�t n� (1 l�n) Thi�u Ni�n V� s� L�i Ki�m hay l� Thanh Ni�n V� s� L�i Ki�m?  Xem r� ch�a ch�a?",4,
	"��i M�t n� Thi�u Ni�n V� S� /prize_mianju_dan_shaonian",
	"��i M�t n� Thanh Ni�n V� /prize_mianju_dan_qingnian",
	"Quay l�i/messenger_prize_mianju",
	"T�m th�i kh�ng ��i ���c!/no")
end

function prize_mianju_dan_qingnian()
	Describe(DescLink_YiGuan..": B�t ��u ��i ��y.",7,
	"M�t n� (1 l�n) - Thanh Ni�n L�i Ki�m [10000 ph�t]/prize_mianju_dan_qinglin_leijian",
	"M�t n� (1 l�n) - Thanh Ni�n Ti�u S��ng [10000 ph�t]/prize_mianju_dan_qinglin_xiaoshuang",
	"M�t n� (1 l�n) - Thanh Ni�n H�a Nh�n [10000 ph�t]/prize_mianju_dan_qinglin_huoren",
	"M�t n� (1 l�n) - Thanh Ni�n H�i ���ng [10000 ph�t]/prize_mianju_dan_qinglin_haitang",
	"M�t n� (1 l�n) - Thanh Ni�n Kim Phong [10000 ph�t]/prize_mianju_dan_qinglin_jinfeng",
	"Quay l�i/prize_mianju_dan",
	"T�m th�i kh�ng ��i ���c!/no")
end

function prize_mianju_dan_shaonian()
	Describe(DescLink_YiGuan..": B�t ��u ��i ��y.",7,
	"M�t n� (1 l�n) - Thi�u Ni�n L�i Ki�m [10000 ph�t]/prize_mianju_dan_shaolin_leijian",
	"M�t n� (1 l�n) - Thi�u Ni�n Ti�u S��ng [10000 ph�t]/prize_mianju_dan_shaolin_xiaoshuang",
	"M�t n� (1 l�n) - Thi�u Ni�n H�a Nh�n [10000 ph�t]/prize_mianju_dan_shaolin_huoren",
	"M�t n� (1 l�n) - Thi�u Ni�n H�i ���ng [10000 ph�t]/prize_mianju_dan_shaolin_haitang",
	"M�t n� (1 l�n) - Thi�u Ni�n Kim Phong [10000 ph�t]/prize_mianju_dan_shaolin_jinfeng",
	"Quay l�i/prize_mianju_dan",
	"T�m th�i kh�ng ��i ���c!/no")
end

function prize_mianju_dan_shaolin_leijian()
	if ( nt_getTask(1205) >= 10000 ) then
		AddItem(0,11,97,0,0,0,0)
		local Uworld1205 = nt_getTask(1205) - 10000
		nt_setTask(1205,Uworld1205)
		Msg2Player("B�n nh�n ���c 1 M�t n� ��ng h�nh")
	else
		Describe(DescLink_YiGuan..": Xin l�i! �i�m t�ch l�y c�a b�n kh�ng ��.",1,"K�t th�c! /no")
	end 
end

function prize_mianju_dan_shaolin_xiaoshuang()
	if ( nt_getTask(1205) >= 10000 ) then
		AddItem(0,11,98,0,0,0,0)
		local Uworld1205 = nt_getTask(1205) - 10000
		nt_setTask(1205,Uworld1205)
		Msg2Player("B�n nh�n ���c 1 M�t n� ��ng h�nh")
	else
		Describe(DescLink_YiGuan..": Xin l�i! �i�m t�ch l�y c�a b�n kh�ng ��.",1,"K�t th�c! /no")
	end 
end

function prize_mianju_dan_shaolin_huoren()
	if ( nt_getTask(1205) >= 10000 ) then
		AddItem(0,11,99,0,0,0,0)
		local Uworld1205 = nt_getTask(1205) - 10000
		nt_setTask(1205,Uworld1205)
		Msg2Player("B�n nh�n ���c 1 M�t n� ��ng h�nh")
	else
		Describe(DescLink_YiGuan..": Xin l�i! �i�m t�ch l�y c�a b�n kh�ng ��.",1,"K�t th�c! /no")
	end 
end

function prize_mianju_dan_shaolin_haitang()
	if ( nt_getTask(1205) >= 10000 ) then
		AddItem(0,11,100,0,0,0,0)
		local Uworld1205 = nt_getTask(1205) - 10000
		nt_setTask(1205,Uworld1205)
		Msg2Player("B�n nh�n ���c 1 M�t n� ��ng h�nh")
	else
		Describe(DescLink_YiGuan..": Xin l�i! �i�m t�ch l�y c�a b�n kh�ng ��.",1,"K�t th�c! /no")
	end 
end

function prize_mianju_dan_shaolin_jinfeng()
	if ( nt_getTask(1205) >= 10000 ) then
		AddItem(0,11,101,0,0,0,0)
		local Uworld1205 = nt_getTask(1205) - 10000
		nt_setTask(1205,Uworld1205)
		Msg2Player("B�n nh�n ���c 1 M�t n� ��ng h�nh")
	else
		Describe(DescLink_YiGuan..": Xin l�i! �i�m t�ch l�y c�a b�n kh�ng ��.",1,"K�t th�c! /no")
	end 
end

function prize_mianju_dan_qinglin_leijian()
	if ( nt_getTask(1205) >= 10000 ) then
		AddItem(0,11,107,0,0,0,0)
		local Uworld1205 = nt_getTask(1205) - 10000
		nt_setTask(1205,Uworld1205)
		Msg2Player("B�n nh�n ���c 1 M�t n� ��ng h�nh")
	else
		Describe(DescLink_YiGuan..": Xin l�i! �i�m t�ch l�y c�a b�n kh�ng ��.",1,"K�t th�c! /no")
	end 
end

function prize_mianju_dan_qinglin_xiaoshuang()
	if ( nt_getTask(1205) >= 10000 ) then
		AddItem(0,11,108,0,0,0,0)
		local Uworld1205 = nt_getTask(1205) - 10000
		nt_setTask(1205,Uworld1205)
		Msg2Player("B�n nh�n ���c 1 M�t n� ��ng h�nh")
	else
		Describe(DescLink_YiGuan..": Xin l�i! �i�m t�ch l�y c�a b�n kh�ng ��.",1,"K�t th�c! /no")
	end 
end

function prize_mianju_dan_qinglin_huoren()
	if ( nt_getTask(1205) >= 10000 ) then
		AddItem(0,11,109,0,0,0,0)
		local Uworld1205 = nt_getTask(1205) - 10000
		nt_setTask(1205,Uworld1205)
		Msg2Player("B�n nh�n ���c 1 M�t n� ��ng h�nh")
	else
		Describe(DescLink_YiGuan..": Xin l�i! �i�m t�ch l�y c�a b�n kh�ng ��.",1,"K�t th�c! /no")
	end 
end

function prize_mianju_dan_qinglin_haitang()
	if ( nt_getTask(1205) >= 10000 ) then
		AddItem(0,11,110,0,0,0,0)
		local Uworld1205 = nt_getTask(1205) - 10000
		nt_setTask(1205,Uworld1205)
		Msg2Player("B�n nh�n ���c 1 M�t n� ��ng h�nh")
	else
		Describe(DescLink_YiGuan..": Xin l�i! �i�m t�ch l�y c�a b�n kh�ng ��.",1,"K�t th�c! /no")
	end 
end

function prize_mianju_dan_qinglin_jinfeng()
	if ( nt_getTask(1205) >= 10000 ) then
		AddItem(0,11,111,0,0,0,0)
		local Uworld1205 = nt_getTask(1205) - 10000
		nt_setTask(1205,Uworld1205)
		Msg2Player("B�n nh�n ���c 1 M�t n� ��ng h�nh")
	else
		Describe(DescLink_YiGuan..": Xin l�i! �i�m t�ch l�y c�a b�n kh�ng ��.",1,"K�t th�c! /no")
	end 
end


function messenger_prize_yaopai()
	Describe(DescLink_YiGuan..": Y�u b�i T�n s� t��ng �ng v�i danh hi�u T�n s� b�n ��t ���c. V� d� b�n l� T�n s� - V�ng th� c� th� ��i b�t c� T�n s� kh�c, nh�ng n�u b�n l� T�n s� - M�c b�n kh�ng th� ��i T�n s� - V�ng. �� hi�u r� r�i ch�? B�t ��u ��i �i.",7,
	"T�n s� l�nh � m�c [50 �i�m]/prize_yaopai_mu",
	"T�n s� l�nh � ��ng [150 �i�m]/prize_yaopai_tong",
	"T�n s� l�nh � B�c [450 �i�m]/prize_yaopai_yin",
	"��i T�n s� Kim b�i [800 �i�m]/prize_yaopai_jin",
	"Ng� T� l�nh b�i - v�ng [1500 �i�m]/prize_yaopai_yuci",
	"Quay l�i/messenger_duihuanprize",
	"T�m th�i kh�ng ��i ���c!/no")
end

function prize_yaopai_mu()
	if ( nt_getTask(1205) >= 50 ) then
		AddItem(6,1,885,1,0,0)
		local Uworld1205 = nt_getTask(1205) - 50
		nt_setTask(1205,Uworld1205)
		Msg2Player("B�n nh�n ���c t�m T�n s� l�nh � m�c.")
	else
		Describe(DescLink_YiGuan..": Xin l�i! �i�m t�ch l�y c�a b�n kh�ng ��.",1,"K�t th�c! /no")
	end 
end

function prize_yaopai_tong()
	if ( nt_getTask(1205) >= 150 ) then
		AddItem(6,1,886,2,0,0)
		local Uworld1205 = nt_getTask(1205) - 150
		nt_setTask(1205,Uworld1205)
		Msg2Player("B�n nh�n ���c t�m T�n s� l�nh � ��ng.")
	else
		Describe(DescLink_YiGuan..": Xin l�i! �i�m t�ch l�y c�a b�n kh�ng ��.",1,"K�t th�c! /no")
	end 
end

function prize_yaopai_yin()
	if ( nt_getTask(1205) >= 450 ) then
		AddItem(6,1,887,3,0,0)
		local Uworld1205 = nt_getTask(1205) - 450
		nt_setTask(1205,Uworld1205)
		Msg2Player("B�n nh�n ���c T�n s� l�nh � B�c.")
	else
		Describe(DescLink_YiGuan..": Xin l�i! �i�m t�ch l�y c�a b�n kh�ng ��.",1,"K�t th�c! /no")
	end
end

function prize_yaopai_jin()
	if ( nt_getTask(1205) >= 800 ) then
		AddItem(6,1,888,4,0,0)
		local Uworld1205 = nt_getTask(1205) - 800
		nt_setTask(1205,Uworld1205)
		Msg2Player("B�n nh�n ���c 1 t�m T�n s� l�nh - V�ng.")
	else
		Describe(DescLink_YiGuan..": Xin l�i! �i�m t�ch l�y c�a b�n kh�ng ��.",1,"K�t th�c! /no")
	end 
end

function prize_yaopai_yuci()
	if ( nt_getTask(1205) >= 1500 ) then
		AddItem(6,1,889,5,0,0)
		local Uworld1205 = nt_getTask(1205) - 1500
		nt_setTask(1205,Uworld1205)
		Msg2Player("B�n nh�n ���c 1 t�m Ng� T� T�n S� y�u b�i")
	else
		Describe(DescLink_YiGuan..": Xin l�i! �i�m t�ch l�y c�a b�n kh�ng ��.",1,"K�t th�c! /no")
	end 
end

function messenger_prize_huangjin()
	Describe(DescLink_YiGuan..": Tri�u ��nh mu�n th��ng cho b�n n�n �� chu�n b� 1 b� Trang b� Ho�ng Kim khi gi�t ��ch s� ���c nh�n ��i kinh nghi�m. B�n mu�n ��i c�i n�o?",6,
		"H�ng �nh tr�m vi�n v�n t�y [100000 �i�m]/prize_huangjin_shenyuan",
		"H�ng �nh qua ki�m t�y ph��ng [70000 �i�m]/prize_huangjin_guajian",
		"H�ng �nh m�c t�c t��ng vong [70000 �i�m]/prize_huangjin_muxu",
		"H�ng �nh h�ng t� chi�u [50000 �i�m]/prize_huangjin_hongxiu",
		"Quay l�i/messenger_duihuanprize",
		"T�m th�i kh�ng ��i/no")
end

function messenger_prize_other()
	Describe(DescLink_YiGuan..": Tri�u ��nh c� nhi�u ph�n th��ng, hi�n b�n v�t ph�m b�n c� th� ��i:",3,
		"Th�n b� ��i H�ng Bao [2000 ph�t]/prize_other_hongbao",
		"Quay l�i/messenger_duihuanprize",
		"T�m th�i kh�ng ��i/no")
end

function prize_other_hongbao()
	if ( nt_getTask(1205) >= 2000 ) then
		local Uworld1205 = nt_getTask(1205) - 2000 
		nt_setTask(1205,Uworld1205)
		AddItem(6,1,402,0,0,0)
		Msg2Player("B�n nh�n ���c 1 Th�n b� ��i H�ng Bao.")
	else
		Describe(DescLink_YiGuan..": Xin l�i! �i�m t�ch l�y c�a b�n kh�ng ��.",1,"K�t th�c! /no")
	end 
end

function prize_huangjin_shenyuan()
	if ( nt_getTask(1205) >= 100000 ) then
		AddGoldItem(0,204)
		local Uworld1205 = nt_getTask(1205) - 100000
		nt_setTask(1205,Uworld1205)
		Msg2Player("B�n nh�n ���c 1 b� trang b� Ho�ng Kim H�ng �nh.")
	else
		Describe(DescLink_YiGuan..": Xin l�i! �i�m t�ch l�y c�a b�n kh�ng ��.",1,"K�t th�c! /no")
	end 
end

function prize_huangjin_guajian()
	if ( nt_getTask(1205) >= 70000 ) then
		AddGoldItem(0,205)
		local Uworld1205 = nt_getTask(1205) - 70000
		nt_setTask(1205,Uworld1205)
		Msg2Player("B�n nh�n ���c 1 b� trang b� Ho�ng Kim H�ng �nh.")
	else
		Describe(DescLink_YiGuan..": Xin l�i! �i�m t�ch l�y c�a b�n kh�ng ��.",1,"K�t th�c! /no")
	end 
end

function prize_huangjin_muxu()
	if ( nt_getTask(1205) >= 70000 ) then
		AddGoldItem(0,206)
		local Uworld1205 = nt_getTask(1205) - 70000
		nt_setTask(1205,Uworld1205)
		Msg2Player("B�n nh�n ���c 1 b� trang b� Ho�ng Kim H�ng �nh.")
	else
		Describe(DescLink_YiGuan..": Xin l�i! �i�m t�ch l�y c�a b�n kh�ng ��.",1,"K�t th�c! /no")
	end 
end

function prize_huangjin_hongxiu()
	if ( nt_getTask(1205) >= 50000 ) then
		AddGoldItem(0,207)
		local Uworld1205 = nt_getTask(1205) - 50000
		nt_setTask(1205,Uworld1205)
		Msg2Player("B�n nh�n ���c 1 b� trang b� Ho�ng Kim H�ng �nh.")
	else
		Describe(DescLink_YiGuan..": Xin l�i! �i�m t�ch l�y c�a b�n kh�ng ��.",1,"K�t th�c! /no")
	end 
end
-------------------------------------------ȡ����ʹ����----------------------------------------------------
function messenger_losemytask()
	if ( GetTask(1204) == 0 ) then
		Describe(DescLink_YiGuan..": B�n ch�a ti�p nh�n nhi�m v� T�n s�, kh�ng th� x�a b�!",1,"K�t th�c ��i tho�i/no")
	else
		Describe(DescLink_YiGuan..": B�n x�c ��nh mu�n x�a b�?",2,"��ng v�y!/messenger_lostall","�� ta suy ngh� l�i!/no")
	end
end
--------------------------------------------����ʲô����ʹ����----------------------------------------------
function messenger_what()
	-- Describe(DescLink_YiGuan..": Nhi�m v� T�n S� l� nhi�m v� gi�p Tri�u ��nh ��a th� cho c�c D�ch Quan � c�c Th�nh Th�, v� g�n ��y n�i c�c trong Tri�u ��nh xu�t hi�n ph�n t�c, cho n�n trong l�c ��a th� ng��i s� g�p kh�ng �t nguy hi�m. Kh�ng c� nh�ng ng��i d�ng c�m tr� tu� si�u ph�m nh�t ��ng v� tinh th�n h�p t�c �o�n k�t th� s� r�t kh� ho�n th�nh nhi�m v�. Ch� c� ��t ��n <color=red> c�p 120 tr� l�n<color> m�i c� th� tham gia. Tr��c m�t ng��i s� g�p nh�ng tr� ng�i c�a �i sau ��y: <color=red> Thi�n B�o Kh�<color>. Trong nh�ng c�a �I n�y c� v� s� k� th� kh�ng gi�ng nhau v� nh�ng c� quan k� qu�i,  ng��i ph�i d�a v�o tr� tu� c�a m�nh �� c� l�a ch�n c�c k� ch�n x�c. Ta ch� c� ��I l�i nh� v�y choc ng��i th�nh c�ng, c� l�n chi�n h�u!",4,
	Describe(DescLink_YiGuan..": Nhi�m v� T�n S� l� nhi�m v� gi�p Tri�u ��nh ��a th� cho c�c D�ch Quan � c�c Th�nh Th�, v� g�n ��y n�i c�c trong Tri�u ��nh xu�t hi�n ph�n t�c, cho n�n trong l�c ��a th� ng��i s� g�p kh�ng �t nguy hi�m. Kh�ng c� nh�ng ng��i d�ng c�m tr� tu� si�u ph�m nh�t ��ng v� tinh th�n h�p t�c �o�n k�t th� s� r�t kh� ho�n th�nh nhi�m v�. Ch� c� ��t ��n <color=red> c�p 80 tr� l�n<color> m�i c� th� tham gia. Tr��c m�t ng��i s� g�p nh�ng tr� ng�i c�a �i sau ��y: <color=red> Phong k� t�a ��<color>. Trong nh�ng c�a �I n�y c� v� s� k� th� kh�ng gi�ng nhau v� nh�ng c� quan k� qu�i,  ng��i ph�i d�a v�o tr� tu� c�a m�nh �� c� l�a ch�n c�c k� ch�n x�c. Ta ch� c� ��I l�i nh� v�y choc ng��i th�nh c�ng, c� l�n chi�n h�u!",4,
	"Gi�i thi�u ��ng c�p ��a ��/messenger_levelmap",
	"Gi�i thi�u nhi�m v� phong k�/messenger_flyhorse",
	--"ɽ�����ؿ�����/messenger_mountaindeity", -- s�n th�n mi?u
	-- "Gi�i thi�u Thi�n B�o kh� /messenger_storehouse", --Thi�n B�o kh�
	--"��ʹ���ƽ���/messenger_orderlevel",
	"Ta mu�n bi�t th�i gian nhi�m v�/messenger_limittotask", -- th�i gian nhi�m v�
	"K�t th�c ��i tho�i/no")
end

function messenger_levelmap()
	--Describe(DescLink_YiGuan.."��������ҵĲ�ͬ�ȼ������ǻ��������ֲ�ͬǿ�ȵĵ�ͼ����������������<color=red>60-89����90-119����120<color>�������֡�",2,"����һ��/messenger_what","�����Ի�/no")
	-- Describe(DescLink_YiGuan..": Tr��c m�t ch� c� <color=red> c�p 120 tr� l�n<color> m�t m�c �� nhi�m v�",2,"Quay l�i/messenger_what","K�t th�c ��i tho�i/no")
	Describe(DescLink_YiGuan..": Tr��c m�t <color=red>c�p 80<color> tr� l�n c� th� tham gia nhi�m v�.",2,"Quay l�i/messenger_what","K�t th�c ��i tho�i/no")
end

function messenger_flyhorse()
	Describe(DescLink_YiGuan..": Trong �i Phong K�, b�n c� th� ch�n ��n c�ng ra, nh� th� coi nh� ho�n th�nh nhi�m v� nh�ng ch� nh�n ���c �i�m danh v�ng. Trong �i, ch�ng t�i c� l�p nh�ng m�c ti�u nhi�m v� ��n gi�n: D�c ���ng b�n s� th�y nhi�u k� hi�u c�a qu�n ta �� l�i, c�ng l�c c� nhi�u gian t� Kim Qu�c. B�n ch� c�n ti�p x�c 5 t�a �� trong b�n �� c� th� ��n c�ng ra t�m B�ch D�c T��ng qu�n qua �i. Nh�ng bi�u hi�n c�a b�n ��u n�m trong t�m m�t c�a trinh s�t ta ph�i ��n. ��i v�i vi�c t�ng ��ng c�p Y�u b�i c�a b�n s� r�t c� l�i.",2,"Quay l�i/messenger_what","K�t th�c ��i tho�i/no")
end

function messenger_mountaindeity()
	Describe(DescLink_YiGuan..": Trong �i S�n Th�n mi�u, b�n c� th� ch�n tr�c ti�p ��n c�ng, nh� th� xem nh� ho�n th�nh nhi�m v�, nh�ng ch� th��ng �i�m danh v�ng. Trong �i, ch�ng t�i c� l�p nh�ng m�c ti�u nhi�m v� ��n gi�n: Trong n�i xu�t hi�n ph�n �� c�a Kinh S� Th�n �ao doanh, b�n h� � trong r�ng c�n tr� th� t�n. Th� l�nh c�a b�n ch�ng x�ng l� �ao Y�u. B�n ch� c�n ��nh b�i 2 t�n �ao Y�u th� c� th� ��n c�ng t�m N�p Lang Thanh Th�nh qua �i. N�u ho�n th�nh nhi�m v� ��i v�i vi�c t�ng ��ng c�p Y�u b�i c�a b�n r�t c� l�i.",2,"Quay l�i/messenger_what","K�t th�c ��i tho�i/no")
end

function messenger_storehouse()
	Describe(DescLink_YiGuan..": Ng��i ho�c ��i tr��ng c�a ng��i khi ti�p nh�n nhi�m v� v��t �i Thi�n B�o Kh�, h� th�ng s� ph�n ph�i cho ng��i ng�u nhi�n  nh�n ���c 5 ch� s�, c�n c� v�o <color-red> d�a theo th� t� <color> c�a ch� s� m� ra <color=red> B�o R��ng<color> c�a s� th� t� ��i �ng trong c�a �i Thi�n B�o Kh�, th� c� th� qua �i. ���ng nhi�n, ph�i m� B�o R��ng, ng��i ph�i ��nh b�i <color=red> boss B�o Kh� Th� H� Gi� <color> b�n c�nh B�o R��ng. <color=red> Ng� H�nh Ph� <color> c� b�n trong K� Tr�n C�c m� ra c� th� nh�n ���c Tri�t Kim Ph�, Tri�t M�c Ph�, Tri�t Th�y Ph�, Tri�t H�a Ph�, Tri�t Th� Ph�, sau khi s� d�ng c� th� gi�p ng��i d� d�ng ��nh b�i boss B�o Kh� Th� H� Gi�.",2,"Quay l�i/messenger_what","K�t th�c ��i tho�i/no")
end

function messenger_orderlevel()
	Describe(DescLink_YiGuan..": C�n c� bi�u hi�n c�a b�n trong �i, ch�ng t�i s� phong cho b�n v�i Quan h�m, b�n s� nh�n ���c nhi�u ph�n th��ng. Y�u b�i hi�n t�i chia th�nh T�n s� - M�c, T�n s� - ��ng, T�n s� - B�c, T�n s� - V�ng v� Ng� T� T�n s� -  V�ng. ��ng th�i, b�n nh�n <color=red>F12<color>, xem trong b�ng <color=red>�i�m t�ch l�y<color> c�a nhi�m v� T�n s�, bi�t ���c v� tr� ch�c quan c�a m�nh. B�n c� th� d�ng �i�m t�ch l�y ��i danh hi�u T�n s�. Sau �� c� th� d�ng �i�m t�ch l�y T�n s� ��i Y�u b�i. Nh�ng Y�u b�i n�y s� t�ng kh� n�ng <color=red>ph�c h�i<color> c�a b�n, n� c� t�c d�ng trong <color=red>1 gi�<color>, s� l�n s� d�ng l� <color=red>5 l�n<color>.",2,"Quay l�i/messenger_what","K�t th�c ��i tho�i/no")
end

function messenger_limittotask()
	Describe(DescLink_YiGuan..": Sau khi ti�p nh�n nhi�m v� T�n s�, b�n c� th�i gian <color=red>2 gi�<color> �� ho�n th�nh. Th�i gian l�m nhi�m v� m�i ng�y l� <color=red>2 gi�<color>. Ch� �! Khi � trong �i, b�n b� ch�t ho�c r�t m�ng xem nh� <color=red>nhi�m v� th�t b�i<color>!",2,"Quay l�i/messenger_what","K�t th�c ��i tho�i/no")
end

function messenger_giveplayerexp(playerexp)

	local j =random(1,3)

	if ( j == 1 ) then
		tl_addPlayerExp(playerexp-500000)
	elseif ( j == 2 ) then
		tl_addPlayerExp(playerexp)
	elseif ( j == 3 ) then
		tl_addPlayerExp(playerexp+500000)
	end
	Msg2Player("Do b�n l�m nhi�m v� T�n s� c� bi�u hi�n t�t, D�ch tr�m cho b�n 1 ph�n th��ng kinh nghi�m!")
	nt_setTask(1224,1)  --���õ��콱������Ϊ��  
	nt_setTask(1223,0)
end

function messenger_lostall()
	nt_setTask(1201,0)
	nt_setTask(1202,0)
	nt_setTask(1203,0)
	nt_setTask(1204,0)
	nt_setTask(1207,0)
	-- nt_setTask(1212,0)
	nt_setTask(1213,0)
	nt_setTask(1214,0)
	nt_setTask(1215,0)
	Msg2Player("Ng��i �� h�y b� th�nh c�ng nhi�m v� T�n S�.")
	WriteLog(format("Account:%s[Name:%s] h�y b� nhi�m v� T�n S�",
			GetAccount(),
			GetName()
			)
		);
end

function no()
end

function check_daily_task_count()
	local nNormalTaskLimit = 2--һ�����ֻ����������ͨ����
	local nIBTaskLimit = 1--һ�����ֻ����1��IB����
	local nTodayCnt = %get_task_daily(1205)
	if nTodayCnt < nNormalTaskLimit then
		return 1--������ͨ�������
	elseif  nTodayCnt < (nNormalTaskLimit + nIBTaskLimit) then
		local nCountIb = CalcItemCount(-1, 6, 1, 2813, -1)
		if nCountIb >= 1 then
			return 2--����ʹ�õ��߱���
		else
			return -1--����ʹ�õ��ߵ�������û��
		end
	end
	return 0--û�����������
end