#include <cstrike>
#define PLUGIN_AUTHOR "IND "
#define PLUGIN_VERSION "0.1"
#define AUTHOR_URL "https://github.com/ind333"

public void OnPluginStart()
{
    HookEvent("cs_win_panel_match", EventCSWIN_Panel);
}

public void EventCSWIN_Panel(Event event, const char[] name, bool dontBroadcast)
{
    int iClient;
    do
    {
        iClient = GetRandomInt(1, MaxClients);
    }
    while(!IsClientInGame(iClient));

    if(IsClientInGame(iClient))
    {
        GiveDrop(iClient);

    }
}

public void GiveDrop(int client)
{
    Protobuf pb = view_as<Protobuf>(StartMessageAll("SendPlayerItemDrops", USERMSG_RELIABLE));

    // Можно добавлять сразу несколько оружий в одно сообщение
    Protobuf entity_updates = pb.AddMessage("entity_updates");

    int itemId[2];

    // Номер оружия csgo
    itemId[0] = 333;
    itemId[1] = 333;

    entity_updates.SetInt("accountid", GetSteamAccountID(client)); // AccountID игрока
    entity_updates.SetInt64("itemid", itemId);
    entity_updates.SetInt("defindex", CS_WeaponIDToItemDefIndex(CSWeapon_AWP)); // Defindex оружия
    entity_updates.SetInt("paintindex", 446); // 446 - AWP | Medusa
    entity_updates.SetInt("rarity", 6); // Редкость оружия. Влияет на задержку выпадения.

    // ==================================================

    /*entity_updates = pb.AddMessage("entity_updates");

    itemId[0] = 444;
    itemId[1] = 444;

    entity_updates.SetInt("accountid", GetSteamAccountID(client));
    entity_updates.SetInt64("itemid", itemId);
    entity_updates.SetInt("defindex", CS_WeaponIDToItemDefIndex(CSWeapon_AWP));
    entity_updates.SetInt("paintindex", 344); // 344 - AWP | Dragon Lore
    entity_updates.SetInt("rarity", 6);

    // ==================================================

    entity_updates = pb.AddMessage("entity_updates");

    itemId[0] = 555;
    itemId[1] = 555;

    entity_updates.SetInt("accountid", GetSteamAccountID(client));
    entity_updates.SetInt64("itemid", itemId);
    entity_updates.SetInt("defindex", CS_WeaponIDToItemDefIndex(CSWeapon_M4A1));
    entity_updates.SetInt("paintindex", 309); // 309 - M4A4 | Howl
    entity_updates.SetInt("rarity", 6);*/

    EndMessage();
}