/** * Assignment 3 EFSM * Tyler Ramsay #26948065 * Dionysios Kefallinos #27019920 *//*** Overall States*/state(dormant).state(init).state(idle).state(monitoring).state(error_diagnosis).state(safe_shutdown)./*** States under init*/state(boot_hw).state(senchk).state(tchk).state(psichk).state(ready)./*** States under monitoring*/state(monidle).state(regulate_environment).state(lockdown)./*** States under lockdown*/state(prep_vpurge).state(alt_temp).state(alp_psi).state(risk_assess).state(safe_status)./*** States under error_diagnosis*/state(error_rcv).state(applicable_rescue).state(reset_module_data)./*** superstates, superstate(S1,S2) succeeds if S1 is the superstate of S2.*/superstate(init, boot_hw).superstate(init, senchk).superstate(init, tchk).superstate(init, psichk).superstate(init, ready).superstate(monitoring, monidle).superstate(rmonitoring, egulate_environment).superstate(monitoring, lockdown).superstate(lockdown, prep_vpurge).superstate(lockdown, alt_temp).superstate(lockdown, alp_psi).superstate(lockdown, risk_assess).superstate(lockdown, safe_status).superstate(error_diagnosis, error_rcv).superstate(error_diagnosis, applicable_rescue).superstate(error_diagnosis, reset_module_data)./*** initialstate*/