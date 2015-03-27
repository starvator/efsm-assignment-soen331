/** * Assignment 3 EFSM * Tyler Ramsay #26948065 * Dionysios Kefallinos #27019920 *//*** Overall States*/state(dormant).state(init).state(idle).state(monitoring).state(error_diagnosis).state(safe_shutdown)./*** States under init*/state(boot_hw).state(senchk).state(tchk).state(psichk).state(ready)./*** States under monitoring*/state(monidle).state(regulate_environment).state(lockdown)./*** States under lockdown*/state(prep_vpurge).state(alt_temp).state(alp_psi).state(risk_assess).state(safe_status)./*** States under error_diagnosis*/state(error_rcv).state(applicable_rescue).state(reset_module_data)./*** superstate, superstate(S1,S2) succeeds if S1 is the superstate of S2.*/superstate(init, boot_hw).superstate(init, senchk).superstate(init, tchk).superstate(init, psichk).superstate(init, ready).superstate(monitoring, monidle).superstate(rmonitoring, egulate_environment).superstate(monitoring, lockdown).superstate(lockdown, prep_vpurge).superstate(lockdown, alt_temp).superstate(lockdown, alp_psi).superstate(lockdown, risk_assess).superstate(lockdown, safe_status).superstate(error_diagnosis, error_rcv).superstate(error_diagnosis, applicable_rescue).superstate(error_diagnosis, reset_module_data)./*** initial_state, initial_state(S1,S2) succeeds if S1 is the initial state of S2.*/initial_state(dormant,null).initial_state(boot_hw, init).initial_state(monidle, monitoring).initial_state(prep_vpurge, lockdown).initial_state(error_rcv, error_diagnosis)./*** transition(Source, Destination, Event, Guard, Action).*//*** Overall transitions*/transition(dormant,exit,kill,null,null).transition(dormant,init,start,null,activateDrivers).transition(init,idle,init_ok,driversLoaded,null).transition(init,error_diagnosis,init_crash,null,'init_err_msg; trigger_shutdown').transition(error_diagnosis,init,retry_init,'retry<3','incr_retry').transition(idle,monitoring,begin_monitoring,null,null).transition(idle,error_diagnosis,idle_crash,null,idle_err).transition(error_diagnosis,idle,idle_rescue,null,null).transition(monitoring,error_diagnosis,monitor_crash,null,moni_err_msg).transition(error_diagnosis,monitoring,moni_rescue,null,null).transition(error_diagnosis,safe_shutdown,shutdown,'retry>3',null).transition(safe_shutdown,dormant,sleep,null,null)./*** init transitions*/transition(boot_hw,senchk,hw_ok,null,check_sensors).transition(senchk,tchk,senok,null,check_t).transition(tchk,psichk,t_ok,null,check_psi).transition(psichk,ready,psi_ok,null,null)./*** monitoring transitions*/transition(monidle,regulate_environment,no_contagion,null,null).transition(monidle,lockdown,contagion_alert,null,'FACILITY_CRIT_MESG; set_inlockdown').transition(regulate_environment,monidle,after_100ms,null,null).transition(lockdown,monidle,purge_succ,null,unset_inlockdown).transition(monitoring,_,null,'inlockdown==false',null)./*** lockdown transitions*/transition(prep_vpurge,alt_temp,initiate_purge,null,lock_doors).transition(prep_vpurge,alt_psi,initiate_purge,lock_doors).transition(alt_temp,risk_assess,tcyc_comp,null,null).transition(alt_psi,risk_assess,psicyc_comp,null,null).transition(risk_assess,prep_vpurge,risk_checked,'risk>=0.01',null).transition(risk_assess,safe_status,risk_checked,'risk<0.01',unlock_doors)./*** error_diagnosis transitions*/transition(error_rcv,applicable_rescue,null,'err_protocol_def==True',null).transition(applicable_rescue,final_state,apply_protocol_recues,null,null).transition(error_rcv,reset_module_data,null,'err_protocol_def==False',null).trnasition(reset_module_data,final_state,reset_to_stable,null,null).