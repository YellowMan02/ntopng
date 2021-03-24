--
-- (C) 2020-21 - ntop.org
--
-- This file contains the snmp constats

local dirs = ntop.getDirs()

-- ################################################################################

local snmp_consts = {}

-- ################################################################################

function snmp_consts.snmp_ifstatus(id)
   local ifstatus = {
      ["1"] = "<font color=green>" .. i18n("snmp.status_up") .. "</font>",
      ["101"] = "<font color=green>" .. i18n("snmp.status_up_in_use") .. "</font>", -- Up and in use (that is, actively seeing traffic)
      ["2"] = "<font color=red>" .. i18n("snmp.status_down") .. "</font>",
      ["3"] = i18n("snmp.testing"),
      ["4"] = i18n("snmp.status_unknown"),
      ["5"] = i18n("snmp.status_dormant"),
      ["6"] = i18n("status_notpresent"),
      ["7"] = "<font color=red>" .. i18n("snmp.status_lowerlayerdown") .. "</font>",
   }

   return(ifstatus[id] or '')
end

-- ################################################################################

function snmp_consts.snmp_duplexstatus(id)
   local dupstatus = {
      ["1"] = i18n("unknown"),
      ["2"] = "<font color=orange>" .. i18n("flow_devices.half_duplex") .. "</font>",
      ["3"] = "<font color=green>" .. i18n("flow_devices.full_duplex") .. "</font>"
   }

   return(dupstatus[id] or '')
end

-- ################################################################################

function snmp_consts.snmp_bridge_mib_TpFdbStatus(id)
   -- http://cric.grenoble.cnrs.fr/Administrateurs/Outils/MIBS/?oid=1.3.6.1.2.1.17.7.1.2.2.1.3
   local ifstatus = {
      ["1"] = i18n("snmp.tp_fbd_status_other"),
      ["2"] = i18n("snmp.tp_fbd_status_invalid"),
      ["3"] = i18n("snmp.tp_fbd_status_learned"),
      ["4"] = i18n("snmp.tp_fbd_status_self"),
      ["5"] = i18n("snmp.tp_fbd_status_mgmt"),
   }

   return(ifstatus[id] or "")
end

-- ################################################################################

function snmp_consts.snmp_ifObjectId(id)
   -- 1.3.6.1.4.1.2636...
   local _id = string.sub(id, 13)

   local hwmodels = {
      ["2636.1.1.1.2.1"] = "Juniper M40",
      ["2636.1.1.1.2.2"] = "Juniper M20",
      ["2636.1.1.1.2.3"] = "Juniper M160",
      ["2636.1.1.1.2.4"] = "Juniper M10",
      ["2636.1.1.1.2.5"] = "Juniper M5",
      ["2636.1.1.1.2.6"] = "Juniper T640",
      ["2636.1.1.1.2.7"] = "Juniper T320",
      ["2636.1.1.1.2.8"] = "Juniper M40e",
      ["2636.1.1.1.2.9"] = "Juniper M320",
      ["2636.1.1.1.2.10"] = "Juniper M7i",
      ["2636.1.1.1.2.11"] = "Juniper M10i",
      ["2636.1.1.1.2.13"] = "Juniper J2300",
      ["2636.1.1.1.2.14"] = "Juniper J4300",
      ["2636.1.1.1.2.15"] = "Juniper J6300",
      ["2636.1.1.1.2.16"] = "Juniper IRM",
      ["2636.1.1.1.2.17"] = "Juniper TX",
      ["2636.1.1.1.2.18"] = "Juniper M120",
      ["2636.1.1.1.2.19"] = "Juniper J4350",
      ["2636.1.1.1.2.20"] = "Juniper J6350",
      ["2636.1.1.1.2.21"] = "Juniper MX960",
      ["2636.1.1.1.2.22"] = "Juniper J4320",
      ["2636.1.1.1.2.23"] = "Juniper J2320",
      ["2636.1.1.1.2.24"] = "Juniper J2350",
      ["2636.1.1.1.2.25"] = "Juniper MX480",
      ["2636.1.1.1.2.26"] = "Juniper SRX5800",
      ["2636.1.1.1.2.27"] = "Juniper T1600",
      ["2636.1.1.1.2.28"] = "Juniper SRX5600",
      ["2636.1.1.1.2.29"] = "Juniper MX240",
      ["2636.1.1.1.2.30"] = "Juniper EX3200",
      ["2636.1.1.1.2.31"] = "Juniper EX4200",
      ["2636.1.1.1.2.32"] = "Juniper EX8208",
      ["2636.1.1.1.2.33"] = "Juniper EX8216",
      ["2636.1.1.1.2.34"] = "Juniper SRX3600",
      ["2636.1.1.1.2.35"] = "Juniper SRX3400",
      ["2636.1.1.1.2.36"] = "Juniper SRX210",
      ["2636.1.1.1.2.37"] = "Juniper TXP",
      ["2636.1.1.1.2.38"] = "Juniper JCS",
      ["2636.1.1.1.2.39"] = "Juniper SRX240",
      ["2636.1.1.1.2.40"] = "Juniper SRX650",
      ["2636.1.1.1.2.41"] = "Juniper SRX100",
      ["2636.1.1.1.2.42"] = "Juniper LN1000V",
      ["2636.1.1.1.2.43"] = "Juniper EX2200",
      ["2636.1.1.1.2.44"] = "Juniper EX4500",
      ["2636.1.1.1.2.45"] = "Juniper FXSeries",
      ["2636.1.1.1.2.46"] = "Juniper IBM4274M02J02M",
      ["2636.1.1.1.2.47"] = "Juniper IBM4274M06J06M",
      ["2636.1.1.1.2.48"] = "Juniper IBM4274M11J11M",
      ["2636.1.1.1.2.49"] = "Juniper SRX1400",
      ["2636.1.1.1.2.50"] = "Juniper IBM4274S58J58S",
      ["2636.1.1.1.2.51"] = "Juniper IBM4274S56J56S",
      ["2636.1.1.1.2.52"] = "Juniper IBM4274S36J36S",
      ["2636.1.1.1.2.53"] = "Juniper IBM4274S34J34S",
      ["2636.1.1.1.2.54"] = "Juniper IBM427348EJ48E",
      ["2636.1.1.1.2.55"] = "Juniper IBM4274E08J08E",
      ["2636.1.1.1.2.56"] = "Juniper IBM4274E16J16E",
      ["2636.1.1.1.2.57"] = "Juniper MX80",
      ["2636.1.1.1.2.58"] = "Juniper SRX220",
      ["2636.1.1.1.2.59"] = "Juniper EXXRE",
      ["2636.1.1.1.2.60"] = "Juniper QFXInterconnect",
      ["2636.1.1.1.2.61"] = "Juniper QFXNode",
      ["2636.1.1.1.2.62"] = "Juniper QFXJVRE",
      ["2636.1.1.1.2.63"] = "Juniper EX4300",
      ["2636.1.1.1.2.64"] = "Juniper SRX110",
      ["2636.1.1.1.2.65"] = "Juniper SRX120",
      ["2636.1.1.1.2.66"] = "Juniper MAG8600",
      ["2636.1.1.1.2.67"] = "Juniper MAG6611",
      ["2636.1.1.1.2.68"] = "Juniper MAG6610",
      ["2636.1.1.1.2.69"] = "Juniper PTX5000",
      ["2636.1.1.1.2.70"] = "Juniper PTX9000",
      ["2636.1.1.1.2.71"] = "Juniper IBM0719J45E",
      ["2636.1.1.1.2.72"] = "Juniper IBMJ08F",
      ["2636.1.1.1.2.73"] = "Juniper IBMJ52F",
      ["2636.1.1.1.2.74"] = "Juniper EX6210",
      ["2636.1.1.1.2.75"] = "Juniper DellJFX3500",
      ["2636.1.1.1.2.76"] = "Juniper EX3300",
      ["2636.1.1.1.2.77"] = "Juniper DELLJSRX3600",
      ["2636.1.1.1.2.78"] = "Juniper DELLJSRX3400",
      ["2636.1.1.1.2.79"] = "Juniper DELLJSRX1400",
      ["2636.1.1.1.2.80"] = "Juniper DELLJSRX5800",
      ["2636.1.1.1.2.81"] = "Juniper DELLJSRX5600",
      ["2636.1.1.1.2.82"] = "Juniper QFXSwitch",
      ["2636.1.1.1.2.83"] = "Juniper T4000",
      ["2636.1.1.1.2.84"] = "Juniper QFX3000",
      ["2636.1.1.1.2.85"] = "Juniper QFX5000",
      ["2636.1.1.1.2.86"] = "Juniper SRX550",
      ["2636.1.1.1.2.87"] = "Juniper ACX",
      ["2636.1.1.1.2.88"] = "Juniper MX40",
      ["2636.1.1.1.2.89"] = "Juniper MX10",
      ["2636.1.1.1.2.90"] = "Juniper MX5",
      ["2636.1.1.1.2.91"] = "Juniper QFXMInterconnect",
      ["2636.1.1.1.2.92"] = "Juniper EX4550",
      ["2636.1.1.1.2.93"] = "Juniper MX2020",
      ["2636.1.1.1.2.94"] = "Juniper Vseries",
      ["2636.1.1.1.2.95"] = "Juniper LN2600",
      ["2636.1.1.1.2.96"] = "Juniper VSRX",
      ["2636.1.1.1.2.100"] = "Juniper QFX3100",
      ["2636.1.1.1.2.97"] = "Juniper MX104",
      ["2636.1.1.1.2.98"] = "Juniper PTX3000",
      ["2636.1.1.1.2.99"] = "Juniper MX2010",
      ["2636.1.1.1.2.100"] = "Juniper QFX3100",
      ["2636.1.1.1.2.101"] = "Juniper LN2800",
      ["2636.1.1.1.2.102"] = "Juniper EX9214",
      ["2636.1.1.1.2.103"] = "Juniper EX9208",
      ["2636.1.1.1.2.104"] = "Juniper EX9204",
      ["2636.1.1.1.2.105"] = "Juniper SRX5400",
      ["2636.1.1.1.2.106"] = "Juniper IBM4274S54J54S",
      ["2636.1.1.1.2.107"] = "Juniper DELLJSRX5400",
      ["2636.1.1.1.2.108"] = "Juniper VMX",
      ["2636.1.1.1.2.109"] = "Juniper VRR",
      ["6027.1.5.2"] = "Dell Z9100",
      ["6027.1.3.23"] = "Dell S3048ON",
      ["11.2.3.7.11.64"] = "HP J9022A",
   }

   local model = hwmodels[_id]

   if(model ~= nil) then
     return(string.format("%s (%s)", id, model))
   end

   return(id)
end

-- ################################################################################

function snmp_consts.snmp_iftype(id)
   local iftype = {
      ["1"] = "other",
      ["2"] = "regular1822",
      ["3"] = "hdh1822",
      ["4"] = "ddnX25",
      ["5"] = "rfc877x25",
      ["6"] = "ethernetCsmacd",
      ["7"] = "iso88023Csmacd",
      ["8"] = "iso88024TokenBus",
      ["9"] = "iso88025TokenRing",
      ["10"] = "iso88026Man",
      ["11"] = "starLan",
      ["12"] = "proteon10Mbit",
      ["13"] = "proteon80Mbit",
      ["14"] = "hyperchannel",
      ["15"] = "fddi",
      ["16"] = "lapb",
      ["17"] = "sdlc",
      ["18"] = "ds1",
      ["19"] = "e1",
      ["20"] = "basicISDN",
      ["21"] = "primaryISDN",
      ["22"] = "propPointToPointSerial",
      ["23"] = "ppp",
      ["24"] = "softwareLoopback",
      ["25"] = "eon",
      ["26"] = "ethernet3Mbit",
      ["27"] = "nsip",
      ["28"] = "slip",
      ["29"] = "ultra",
      ["30"] = "ds3",
      ["31"] = "sip",
      ["32"] = "frameRelay",
      ["33"] = "rs232",
      ["34"] = "para",
      ["35"] = "arcnet",
      ["36"] = "arcnetPlus",
      ["37"] = "atm",
      ["38"] = "miox25",
      ["39"] = "sonet",
      ["40"] = "x25ple",
      ["41"] = "iso88022llc",
      ["42"] = "localTalk",
      ["43"] = "smdsDxi",
      ["44"] = "frameRelayService",
      ["45"] = "v35",
      ["46"] = "hssi",
      ["47"] = "hippi",
      ["48"] = "modem",
      ["49"] = "aal5",
      ["50"] = "sonetPath",
      ["51"] = "sonetVT",
      ["52"] = "smdsIcip",
      ["53"] = "propVirtual",
      ["54"] = "propMultiplexor",
      ["55"] = "ieee80212",
      ["56"] = "fibreChannel",
      ["57"] = "hippiInterface",
      ["58"] = "frameRelayInterconnect",
      ["59"] = "aflane8023",
      ["60"] = "aflane8025",
      ["61"] = "cctEmul",
      ["62"] = "fastEther",
      ["63"] = "isdn",
      ["64"] = "v11",
      ["65"] = "v36",
      ["66"] = "g703at64k",
      ["67"] = "g703at2mb",
      ["68"] = "qllc",
      ["69"] = "fastEtherFX",
      ["70"] = "channel",
      ["71"] = "ieee80211",
      ["72"] = "ibm370parChan",
      ["73"] = "escon",
      ["74"] = "dlsw",
      ["75"] = "isdns",
      ["76"] = "isdnu",
      ["77"] = "lapd",
      ["78"] = "ipSwitch",
      ["79"] = "rsrb",
      ["80"] = "atmLogical",
      ["81"] = "ds0",
      ["82"] = "ds0Bundle",
      ["83"] = "bsc",
      ["84"] = "async",
      ["85"] = "cnr",
      ["86"] = "iso88025Dtr",
      ["87"] = "eplrs",
      ["88"] = "arap",
      ["89"] = "propCnls",
      ["90"] = "hostPad",
      ["91"] = "termPad",
      ["92"] = "frameRelayMPI",
      ["93"] = "x213",
      ["94"] = "adsl",
      ["95"] = "radsl",
      ["96"] = "sdsl",
      ["97"] = "vdsl",
      ["98"] = "iso88025CRFPInt",
      ["99"] = "myrinet",
      ["100"] = "voiceEM",
      ["101"] = "voiceFXO",
      ["102"] = "voiceFXS",
      ["103"] = "voiceEncap",
      ["104"] = "voiceOverIp",
      ["105"] = "atmDxi",
      ["106"] = "atmFuni",
      ["107"] = "atmIma",
      ["108"] = "pppMultilinkBundle",
      ["109"] = "ipOverCdlc",
      ["110"] = "ipOverClaw",
      ["111"] = "stackToStack",
      ["112"] = "virtualIpAddress",
      ["113"] = "mpc",
      ["114"] = "ipOverAtm",
      ["115"] = "iso88025Fiber",
      ["116"] = "tdlc",
      ["117"] = "gigabitEthernet",
      ["118"] = "hdlc",
      ["119"] = "lapf",
      ["120"] = "v37",
      ["121"] = "x25mlp",
      ["122"] = "x25huntGroup",
      ["123"] = "trasnpHdlc",
      ["124"] = "interleave",
      ["125"] = "fast",
      ["126"] = "ip",
      ["127"] = "docsCableMaclayer",
      ["128"] = "docsCableDownstream",
      ["129"] = "docsCableUpstream",
      ["130"] = "a12MppSwitch",
      ["131"] = "tunnel",
      ["132"] = "coffee",
      ["133"] = "ces",
      ["134"] = "atmSubInterface",
      ["135"] = "l2vlan",
      ["136"] = "l3ipvlan",
      ["137"] = "l3ipxvlan",
      ["138"] = "digitalPowerline",
      ["139"] = "mediaMailOverIp",
      ["140"] = "dtm",
      ["141"] = "dcn",
      ["142"] = "ipForward",
      ["143"] = "msdsl",
      ["144"] = "ieee1394",
      ["145"] = "if-gsn",
      ["146"] = "dvbRccMacLayer",
      ["147"] = "dvbRccDownstream",
      ["148"] = "dvbRccUpstream",
      ["149"] = "atmVirtual",
      ["150"] = "mplsTunnel",
      ["151"] = "srp",
      ["152"] = "voiceOverAtm",
      ["153"] = "voiceOverFrameRelay",
      ["154"] = "idsl",
      ["155"] = "compositeLink",
      ["156"] = "ss7SigLink",
      ["157"] = "propWirelessP2P",
      ["158"] = "frForward",
      ["159"] = "rfc1483",
      ["160"] = "usb",
      ["161"] = "ieee8023adLag",
      ["162"] = "bgppolicyaccounting",
      ["163"] = "frf16MfrBundle",
      ["164"] = "h323Gatekeeper",
      ["165"] = "h323Proxy",
      ["166"] = "mpls",
      ["167"] = "mfSigLink",
      ["168"] = "hdsl2",
      ["169"] = "shdsl",
      ["170"] = "ds1FDL",
      ["171"] = "pos",
      ["172"] = "dvbAsiIn",
      ["173"] = "dvbAsiOut",
      ["174"] = "plc",
      ["175"] = "nfas",
      ["176"] = "tr008",
      ["177"] = "gr303RDT",
      ["178"] = "gr303IDT",
      ["179"] = "isup",
      ["180"] = "propDocsWirelessMaclayer",
      ["181"] = "propDocsWirelessDownstream",
      ["182"] = "propDocsWirelessUpstream",
      ["183"] = "hiperlan2",
      ["184"] = "propBWAp2Mp",
      ["185"] = "sonetOverheadChannel",
      ["186"] = "digitalWrapperOverheadChannel",
      ["187"] = "aal2",
      ["188"] = "radioMAC",
      ["189"] = "atmRadio",
      ["190"] = "imt",
      ["191"] = "mvl",
      ["192"] = "reachDSL",
      ["193"] = "frDlciEndPt",
      ["194"] = "atmVciEndPt",
      ["195"] = "opticalChannel",
      ["196"] = "opticalTransport",
      ["197"] = "propAtm",
      ["198"] = "voiceOverCable",
      ["199"] = "infiniband",
      ["200"] = "teLink",
      ["201"] = "q2931",
      ["202"] = "virtualTg",
      ["203"] = "sipTg",
      ["204"] = "sipSig",
      ["205"] = "docsCableUpstreamChannel",
      ["206"] = "econet",
      ["207"] = "pon155",
      ["208"] = "pon622",
      ["209"] = "bridge",
      ["210"] = "linegroup",
      ["211"] = "voiceEMFGD",
      ["212"] = "voiceFGDEANA",
      ["213"] = "voiceDID",
      ["214"] = "mpegTransport",
      ["215"] = "sixToFour",
      ["216"] = "gtp",
      ["217"] = "pdnEtherLoop1",
      ["218"] = "pdnEtherLoop2",
      ["219"] = "opticalChannelGroup",
      ["220"] = "homepna",
      ["221"] = "gfp",
      ["222"] = "ciscoISLvlan",
      ["223"] = "actelisMetaLOOP",
      ["224"] = "fcipLink",
      ["225"] = "rpr",
      ["226"] = "qam",
      ["227"] = "lmp",
      ["228"] = "cblVectaStar",
      ["229"] = "docsCableMCmtsDownstream",
      ["230"] = "adsl2",
      ["231"] = "macSecControlledIF",
      ["232"] = "macSecUncontrolledIF",
      ["233"] = "aviciOpticalEther",
      ["234"] = "atmbond"
   }

   return(iftype[id] or "")
end

-- ################################################################################

return snmp_consts
