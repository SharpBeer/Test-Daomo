// This is a comment
// uncomment the line below if you want to write a filterscript
//#define FILTERSCRIPT

#include <a_samp>
#include <zcmd>

#define 		DIALOG_XINVIEC 				1000

#if defined FILTERSCRIPT

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" Blank Filterscript by your name here");
	print("--------------------------------------\n");
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

#else

main()
{
	print("\n----------------------------------");
	print(" Blank Gamemode by your name here");
	print("----------------------------------\n");
}

#endif

enum pInfo
{
	pJob,
	pCash
};
new PlayerInfo[MAX_PLAYERS][pInfo];

new DaoMo;
new ThoiGianDaoMo[MAX_PLAYERS];

public OnGameModeInit()
{
	// Don't use these lines if it's a filterscript
	SetGameModeText("Blank Script");
	AddPlayerClass(0, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);

	DaoMo = CreateActor(78, 810.6816,-1109.5469,25.7841,356.5741);
	return 1;
}

public OnGameModeExit()
{
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	SetPlayerPos(playerid, 1958.3783, 1343.1572, 15.3746);
	SetPlayerCameraPos(playerid, 1958.3783, 1343.1572, 15.3746);
	SetPlayerCameraLookAt(playerid, 1958.3783, 1343.1572, 15.3746);
	return 1;
}

public OnPlayerConnect(playerid)
{
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	return 1;
}

public OnPlayerSpawn(playerid)
{
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	return 1;
}

public OnPlayerText(playerid, text[])
{
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if (strcmp("/mycommand", cmdtext, true, 10) == 0)
	{
		// Do something here
		return 1;
	}
	return 0;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	if(GetPVarInt(playerid, "DangDaoMo") == 1)
	{
		if(GetPlayerWeapon(playerid) != 6) return SendClientMessage(playerid, -1, "[!] Ban phai cam dung cu lam viec tren tay");
		SetPVarInt(playerid, "TongThoiGianDaoMo", 20);
		SendClientMessage(playerid, -1, "[-] Vui long cho 20 giay de dao mo xong");
		ApplyAnimation(playerid, "BASEBALL", "Bat_4", 4.1, 1, 0, 0, 1, 0, 1);
		KillTimer(ThoiGianDaoMo[playerid]);
		ThoiGianDaoMo[playerid] = SetTimerEx("DemThoiGianDaoMo", 1000, false, "i", playerid);
		DisablePlayerCheckpoint(playerid);
	}
	return 1;
}

stock Random(min, max)
{
    new a = random(max - min) + min;
    return a;
}

forward DemThoiGianDaoMo(playerid);
public DemThoiGianDaoMo(playerid)
{
	if(GetPVarInt(playerid, "TongThoiGianDaoMo") > 0) {
		SetPlayerArmedWeapon(playerid, 6);
		SetPVarInt(playerid, "TongThoiGianDaoMo", GetPVarInt(playerid, "TongThoiGianDaoMo")-1);
		ThoiGianDaoMo[playerid] = SetTimerEx("DemThoiGianDaoMo", 1000, false, "i", playerid);
		ApplyAnimation(playerid, "BASEBALL", "Bat_4", 4.1, 1, 0, 0, 1, 0, 1);
	}
	else {
		ClearAnimations(playerid);
		new money, string[128];
		money = Random(5000, 20000);
		format(string, sizeof(string), "[+] Ban da nhan duoc %d$ khi dao mo", money);
		SendClientMessage(playerid, -1, string);
		PlayerInfo[playerid][pCash]+=money;
		GivePlayerMoney(playerid, money);
		NhanDiemNgauNhien(playerid);
	}
	return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

public OnRconCommand(cmd[])
{
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	return 1;
}

public OnObjectMoved(objectid)
{
	return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	return 1;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
	return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	return 1;
}

stock RangeActor(playerid, actorid, Float:radius = 5.0)
{
    new Float:x,
        Float:y,
        Float:z;

    if (GetActorPos(actorid, x, y, z))
    {
        return IsPlayerInRangeOfPoint(playerid, radius, x, y, z);
    }
    return 0;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if((newkeys & KEY_HANDBRAKE) && (newkeys & KEY_YES)) {
		if(RangeActor(playerid, DaoMo)) { // Dao mo
       		if(PlayerInfo[playerid][pJob] != 1) ShowPlayerDialog(playerid, DIALOG_XINVIEC, DIALOG_STYLE_LIST, "Xin Viec", "Xin viec\nTu bo cong viec", "Dong y", "Khong");
       		else ShowPlayerDialog(playerid, DIALOG_XINVIEC, DIALOG_STYLE_LIST, "Xin Viec", "Xin viec\nTu bo cong viec\nLay dung cu", "Dong y", "Khong");
        }
	}
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	return 1;
}

public OnPlayerUpdate(playerid)
{
	return 1;
}

public OnPlayerStreamIn(playerid, forplayerid)
{
	return 1;
}

public OnPlayerStreamOut(playerid, forplayerid)
{
	return 1;
}

public OnVehicleStreamIn(vehicleid, forplayerid)
{
	return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == DIALOG_XINVIEC) 
	{
		if(response) 
		{
			if(listitem == 0)
			{
				if(PlayerInfo[playerid][pJob] != 1) 
				{
					SendClientMessage(playerid, -1, "[+] Ban da xin viec dao mo");
					PlayerInfo[playerid][pJob] = 1;
				}
			}
			if(listitem == 1)
			{
				if(PlayerInfo[playerid][pJob] == 1) 
				{
					SendClientMessage(playerid, -1, "[+] Ban da nghi viec dao mo");
					PlayerInfo[playerid][pJob] = 0;
				}
			}
			if(listitem == 2)
			{
				SendClientMessage(playerid, -1, "[+] Ban da lay dung cu lam viec /batdaulamviec de lam viec");
				GivePlayerWeapon(playerid, 6, 60000);
			}
		}
	}
	return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}

CMD:batdaulamviec(playerid, params[]) {
	if(PlayerInfo[playerid][pJob] != 1) return SendClientMessage(playerid, -1, "[!] Ban khong phai cong nhan dao mo");
	if(GetPlayerWeapon(playerid) != 6) return SendClientMessage(playerid, -1, "[!] Ban phai cam dung cu lam viec tren tay");
	if(GetPVarInt(playerid, "TongThoiGianDaoMo") > 0) return SendClientMessage(playerid, -1, "[!] Ban dang dao mo");
	NhanDiemNgauNhien(playerid);
	return 1;
}

CMD:dunglamviec(playerid, params[]) {
	if(GetPVarInt(playerid, "DangDaoMo") == 1)
	{
		ClearAnimations(playerid);
		KillTimer(ThoiGianDaoMo[playerid]);
		DeletePVar(playerid, "TongThoiGianDaoMo");
		DisablePlayerCheckpoint(playerid);
		SendClientMessage(playerid, -1, "[-] Ban da dung lam viec");
		DeletePVar(playerid, "DangDaoMo");
	}
	return 1;
}

NhanDiemNgauNhien(playerid) {
	SetPVarInt(playerid, "DangDaoMo", 1);
	new Float:x, Float:y, Float:z;
	switch(random(15)) {
		case 0: x = 843.3756, y = -1111.4231, z = 24.1732;
		case 1: x = 848.1671, y = -1111.0685, z = 24.1795;
		case 2: x = 857.4103, y = -1111.1829, z = 24.1853;
		case 3: x = 861.9197, y = -1111.2606, z = 24.1839;
		case 4: x = 867.2540, y = -1111.2606, z = 24.1839;
		case 5: x = 871.2223, y = -1111.1508, z = 24.1780;
		case 6: x = 843.4484, y = -1096.5693, z = 24.3040;
		case 7: x = 847.8633, y = -1095.9808, z = 24.3040;
		case 8: x = 857.1832, y = -1096.1689, z = 24.2969;
		case 9: x = 866.2698, y = -1096.1714, z = 24.2969;
		case 10: x = 871.0375, y = -1096.0770, z = 24.2969;
		case 11: x = 870.0903, y = -1118.5970, z = 24.0471;
		case 12: x = 864.3102, y = -1118.7194, z = 24.0449;
		case 13: x = 857.5448, y = -1118.6477, z = 24.0540;
		case 14: x = 848.5281, y = -1119.0428, z = 24.0393;
		case 15: x = 843.3561, y = -1119.5311, z = 24.0307;
	}
	SetPlayerCheckpoint(playerid, x, y, z, 3.0);
	return 1;
}