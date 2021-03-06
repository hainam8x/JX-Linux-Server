-- 宋金战诏书 用来把玩家传送到宋金战报名点  需要加限制：宋金战场内（包括单条地图）不能使用
-- Liu Kuo
-- 2004.12.13
Include("\\script\\battles\\battlehead.lua");
Include("\\script\\battles\\battleinfo.lua");


function main()
	W,X,Y = GetWorldPos();

	local nSongNumber = 60; -- 宋方人数
	local nJinNumber = 70;  -- 金方人数
	local nMapId = W;
	tbFORBIDDEN_MAP = { 197, 208, 209, 210, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222, 223, 334, 335, 356, 337, 338,339,387,388,389,390,391,392,393,394,395,396,397,398,399,400,401,402,403,404,405,406,407,408,409,410,411,412,413,414,415,416,417,418,419,420,421,422,423,424,425,426,427,428,429,430,431,432,433,434,435,436,437,438,439,440,441,442,443,444,445,446,447,448,449,450,451,452,453,454,455,456,457,458,459,460,461,462,463,520,521,522,523,524,525,526,527,528,529,530,531,532,533,534,535,536,537,538,825,826};	-- 禁用特殊地图
	tbCD_MAP = {516, 517, 580, 581}	--烽火连城守城地图
	for j = 1, getn(tbFORBIDDEN_MAP) do
		if ( nMapId == tbFORBIDDEN_MAP[j] ) then
			Msg2Player("Khu v鵦 n祔 kh玭g th� s� d鬾g o c�.");
			return 1;
		end
	end		
	for i = 1, getn(tbBATTLEMAP) do 
		if ( nMapId == tbBATTLEMAP[i] ) then
			Msg2Player("Khu v鵦 n祔 kh玭g th� s� d鬾g o c�.");
			return 1;
		end
	end
	if (nMapId >= 464 and nMapId <= 511) then
		Msg2Player("Khu v鵦 n祔 kh玭g th� s� d鬾g o c�.");
		return 1
	end
	--[DinhHQ]
	--20110407: 当闯关30，不能使用宋金诏书
	if (nMapId == 957) then
		Msg2Player("Khu v鵦 n祔 kh玭g th� s� d鬾g o c�.");
		return 1
	end
	if ( nMapId >= 235 and nMapId <= 318 ) then
		Msg2Player("Khu v鵦 n祔 kh玭g th� s� d鬾g o c�.");
		return 1;
	end
	for j = 1, getn(tbCD_MAP) do
		if ( nMapId == tbCD_MAP[j] ) then
			Msg2Player("Khu v鵦 n祔 kh玭g th� s� d鬾g o c�.");
			return 1;
		end
	end	
	if ( nMapId >= 540 and nMapId <= 583 ) then
		Msg2Player("Khu v鵦 n祔 kh玭g th� s� d鬾g o c�.");
		return 1;
	end
	if (nMapId >= 605 and nMapId <= 613) then	--武林第一帮地图
		Msg2Player("Khu v鵦 n祔 kh玭g th� s� d鬾g o c�.");
		return 1;
	end
	
	if (nMapId == 162) then	--武林第一帮地图
		Msg2Player("Khu v鵦 n祔 kh玭g th� s� d鬾g o c�.");
		return 1;
	end
	
	Say ( "<#> <color=red>T鑞g kim chi課 chi誹 s竎h <color><enter><enter><color><enter><enter> nh﹏ s� chi誱 璾 phng tuy � chi課 trng c� m閠 輙 璾 th�, nh璶g t 頲 <enter> t輈h l騳 s� 輙, ngi mu鑞 甶 u nh蕋 phng ghi danh 甶觤 y ?", 
			4, "\Ti課 v祇 甶觤 t鑞g qu﹏ ghi danh/ToSong", 
			"\Ti課 v祇 kim qu﹏ ghi danh 甶觤/ToJin", 
			"H� .... ta l� o binh/Cancel" );
	-- 空格不要改了，为了居中显示
	return 1;

end

function ToSong()	-- 进入宋方报名点	
	if ( GetLevel() < 40 ) then
		Talk( 1, "", "T鑞g kim chi課 trng b﹜ gi� t祅 kh鑓, ngi c遪 ch璦 y 40 c蕄, hay l� trc l辌h l穖 m閠 phen 甶." );
	elseif ( GetLevel() >= 40 and GetLevel() < 80 ) then
		if (DelCommonItem( 6, 1, 155, 1, 0, 0) == 1) then
			NewWorld( 323, 1541, 3178);
			SetFightState(0);
			DisabledUseTownP(0); -- 不限制其使用回城符
			Msg2Player( "T韎 s� c蕄 t鑞g kim chi課 trng t鑞g phng ghi danh 甶觤." );
		end
	elseif ( GetLevel() >= 80 and GetLevel() < 120 ) then
		if (DelCommonItem( 6, 1, 155, 1, 0, 0) == 1) then
			NewWorld( 324, 1541, 3178);
			SetFightState(0);
			DisabledUseTownP(0); -- 不限制其使用回城符
			Msg2Player( "T韎 trung c蕄 t鑞g kim chi課 trng t鑞g phng ghi danh 甶觤" );
		end
	else
		if (DelCommonItem( 6, 1, 155, 1, 0, 0) == 1) then
			NewWorld( 162,1608,3254);
			SetFightState(0);
			DisabledUseTownP(0); -- 不限制其使用回城符
			Msg2Player( "T韎 cao c蕄 t鑞g kim chi課 trng t鑞g phng ghi danh 甶觤." );
		end
	end
end

function ToJin()	-- 进入金方报名点
	if ( GetLevel() < 40 ) then
		Talk( 1, "", "T鑞g kim chi課 trng b﹜ gi� t祅 kh鑓, ngi c遪 ch璦 y 40 c蕄, hay l� trc l辌h l穖 m閠 phen 甶." );
	elseif ( GetLevel() >= 40 and GetLevel() < 80 ) then
		if (DelCommonItem( 6, 1, 155, 1, 0, 0) == 1) then
			NewWorld( 323, 1570, 3085);
			SetFightState(0);
			DisabledUseTownP(0); -- 不限制其使用回城符
			Msg2Player( "T韎 s� c蕄 t鑞g kim chi課 trng kim phng ghi danh 甶觤" );
		end
	elseif ( GetLevel() >= 80 and GetLevel() < 120 ) then
		if (DelCommonItem( 6, 1, 155, 1, 0, 0) == 1) then
			NewWorld( 324, 1570, 3085);
			SetFightState(0);
			DisabledUseTownP(0); -- 不限制其使用回城符
			Msg2Player( "T韎 trung c蕄 t鑞g kim chi課 trng kim phng ghi danh 甶觤" );
		end
	else
		if (DelCommonItem( 6, 1, 155, 1, 0, 0) == 1) then
			NewWorld( 162,1566,3277);
			SetFightState(0);
			DisabledUseTownP(0); -- 不限制其使用回城符
			Msg2Player( "T韎 cao c蕄 t鑞g kim chi課 trng kim phng ghi danh 甶觤" );
		end
	end
end


function Cancel()
end
