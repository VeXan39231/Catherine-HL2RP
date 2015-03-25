Schema.vo = { normalVoice = { }, dispatchVoice = { } }

local combine = Schema.isCombine
local citizen = { FACTION_CITIZEN }

function Schema.vo.RegisterNormal( faction, command, output, sound )
	Schema.vo.normalVoice[ #Schema.vo.normalVoice + 1 ] = {
		faction = faction,
		command = command,
		output = output,
		sound = sound
	}
end

function Schema.vo.RegisterDispatch( command, output, sound )
	Schema.vo.dispatchVoice[ #Schema.vo.dispatchVoice + 1 ] = {
		command = command,
		output = output,
		sound = sound
	}
end

Schema.vo.RegisterDispatch( "Anti-Citizen", "Attention ground units. Anti-citizen reported in this community. Code: LOCK, CAUTERIZE, STABILIZE.", "npc/overwatch/cityvoice/f_anticitizenreport_spkr.wav" )
Schema.vo.RegisterDispatch( "Anti-Civil", "Protection team alert. Evidence of anti-civil activity in this community. Code: ASSEMBLE, PLAN, CONTAIN.", "npc/overwatch/cityvoice/f_anticivilevidence_3_spkr.wav" )
Schema.vo.RegisterDispatch( "Person Interest", "Attention please. Unidentified person of interest confirm your civil status with local protection team immediately.", "npc/overwatch/cityvoice/f_confirmcivilstatus_1_spkr.wav" )
Schema.vo.RegisterDispatch( "Citizen Inaction", "Citizen reminder. Inaction is conspiracy. Report counter behaviour to a Civil Protection team immediately.", "npc/overwatch/cityvoice/f_innactionisconspiracy_spkr.wav" )
Schema.vo.RegisterDispatch( "Unrest Structure", "Alert community ground protection units, local unrest structure detected. ASSEMBLE, ADMINISTER, PACIFY.", "npc/overwatch/cityvoice/f_localunrest_spkr.wav" )
Schema.vo.RegisterDispatch( "Status Evasion", "Attention protection team. Status evasion in progress in this community. RESPOND, ISOLATE, ENQUIRE.", "npc/overwatch/cityvoice/f_protectionresponse_1_spkr.wav" )
Schema.vo.RegisterDispatch( "Lockdown", "Attention all ground protection teams. Judgment waiver now in effect. Capital prosecution is discretionary.", "npc/overwatch/cityvoice/f_protectionresponse_5_spkr.wav" )
Schema.vo.RegisterDispatch( "Rations Deducted", "Attention occupants. Your block is now charged with permissive inactive cohesion. Five ration units deducted.", "npc/overwatch/cityvoice/f_rationunitsdeduct_3_spkr.wav" )
Schema.vo.RegisterDispatch( "Inspection", "Citizen notice. Priority identification check in progress. Please assemble in your designated inspection positions.", "npc/overwatch/cityvoice/f_trainstation_assemble_spkr.wav" )
Schema.vo.RegisterDispatch( "Inspection 2", "Attention please. All citizens in local residential block, assume your inspection positions.", "npc/overwatch/cityvoice/f_trainstation_assumepositions_spkr.wav" )
Schema.vo.RegisterDispatch( "Miscount Detected", "Attention resident. Miscount detected in your block. Co-operation with your Civil Protection team permit full ration reward.", "npc/overwatch/cityvoice/f_trainstation_cooperation_spkr.wav" )
Schema.vo.RegisterDispatch( "Infection", "Attention resident. This block contains potential civil infection. INFORM, CO-OPERATE, ASSEMBLE.", "npc/overwatch/cityvoice/f_trainstation_inform_spkr.wav" )
Schema.vo.RegisterDispatch( "Relocation", "Citizen notice. Failure to co-operate will result in permanent off-world relocation.", "npc/overwatch/cityvoice/f_trainstation_offworldrelocation_spkr.wav" )
Schema.vo.RegisterDispatch( "Unrest Code", "Attention community. Unrest procedure code is now in effect. INOCULATE, SHIELD, PACIFY. Code: PRESSURE, SWORD, STERILIZE.", "npc/overwatch/cityvoice/f_unrestprocedure1_spkr.wav" )
Schema.vo.RegisterDispatch( "Evasion", "Attention please. Evasion behaviour consistent with mal-compliant defendant. Ground protection team, alert. Code: ISOLATE, EXPOSE, ADMINISTER.", "npc/overwatch/cityvoice/f_evasionbehavior_2_spkr.wav" )
Schema.vo.RegisterDispatch( "Individual", "Individual. You are charged with social endangerment, level one. Protection unit, prosecution code: DUTY, SWORD, MIDNIGHT.", "npc/overwatch/cityvoice/f_sociolevel1_4_spkr.wav" )
Schema.vo.RegisterDispatch( "Autonomous", "Attention all ground protection teams. Autonomous judgement is now in effect, sentencing is now discretionary. Code: AMPUTATE, ZERO, CONFIRM.", "npc/overwatch/cityvoice/f_protectionresponse_4_spkr.wav" )
Schema.vo.RegisterDispatch( "Citizenship", "Individual. You are convicted of multi anti-civil violations. Implicit citizenship revoked. Status: MALIGNANT.", "npc/overwatch/cityvoice/f_citizenshiprevoked_6_spkr.wav" )
Schema.vo.RegisterDispatch( "Malcompliance", "Individual. You are charged with capital malcompliance, anti-citizen status approved.", "npc/overwatch/cityvoice/f_capitalmalcompliance_spkr.wav" )
Schema.vo.RegisterDispatch( "Exogen", "Overwatch acknowledges critical exogen breach, AirWatch augmentation force dispatched and inbound. Hold for reinforcements.", "npc/overwatch/cityvoice/fprison_airwatchdispatched.wav" )
Schema.vo.RegisterDispatch( "Failure", "Attention ground units. Mission failure will result in permanent off-world assignment. Code reminder: SACRIFICE, COAGULATE, PLAN.", "npc/overwatch/cityvoice/fprison_missionfailurereminder.wav" )

Schema.vo.RegisterNormal( combine, "Sweeping", "Sweeping for suspect.", "npc/metropolice/hiding02.wav" )
Schema.vo.RegisterNormal( combine, "Isolate", "Isolate!", "npc/metropolice/hiding05.wav" )
Schema.vo.RegisterNormal( combine, "You Can Go", "Alright, you can go.", "npc/metropolice/vo/allrightyoucango.wav" )
Schema.vo.RegisterNormal( combine, "Need Assistance", "Eleven-ninety-nine, officer needs assistance!", "npc/metropolice/vo/11-99officerneedsassistance.wav" )
Schema.vo.RegisterNormal( combine, "Administer", "Administer.", "npc/metropolice/vo/administer.wav" )
Schema.vo.RegisterNormal( combine, "Affirmative", "Affirmative.", "npc/metropolice/vo/affirmative.wav" )
Schema.vo.RegisterNormal( combine, "All Units Move In", "All units move in!", "npc/metropolice/vo/allunitsmovein.wav" )
Schema.vo.RegisterNormal( combine, "Amputate", "Amputate.", "npc/metropolice/vo/amputate.wav" )
Schema.vo.RegisterNormal( combine, "Anti-Citizen", "Anti-citizen.", "npc/metropolice/vo/anticitizen.wav" )
Schema.vo.RegisterNormal( combine, "Citizen", "Citizen.", "npc/metropolice/vo/citizen.wav" )
Schema.vo.RegisterNormal( combine, "Copy", "Copy.", "npc/metropolice/vo/copy.wav" )
Schema.vo.RegisterNormal( combine, "Cover Me", "Cover me, I'm going in!", "npc/metropolice/vo/covermegoingin.wav" )
Schema.vo.RegisterNormal( combine, "Assist Trespass", "Assist for a criminal trespass!", "npc/metropolice/vo/criminaltrespass63.wav" )
Schema.vo.RegisterNormal( combine, "Destroy Cover", "Destroy that cover!", "npc/metropolice/vo/destroythatcover.wav" )
Schema.vo.RegisterNormal( combine, "Don't Move", "Don't move!", "npc/metropolice/vo/dontmove.wav" )
Schema.vo.RegisterNormal( combine, "Final Verdict", "Final verdict administered.", "npc/metropolice/vo/finalverdictadministered.wav" )
Schema.vo.RegisterNormal( combine, "Final Warning", "Final warning!", "npc/metropolice/vo/finalwarning.wav" )
Schema.vo.RegisterNormal( combine, "First Warning", "First warning, move away!", "npc/metropolice/vo/firstwarningmove.wav" )
Schema.vo.RegisterNormal( combine, "Get Down", "Get down!", "npc/metropolice/vo/getdown.wav" )
Schema.vo.RegisterNormal( combine, "Get Out", "Get out of here!", "npc/metropolice/vo/getoutofhere.wav" )
Schema.vo.RegisterNormal( combine, "Suspect One", "I got suspect one here.", "npc/metropolice/vo/gotsuspect1here.wav" )
Schema.vo.RegisterNormal( combine, "Help", "Help!", "npc/metropolice/vo/help.wav" )
Schema.vo.RegisterNormal( combine, "Running", "He's running!", "npc/metropolice/vo/hesrunning.wav" )
Schema.vo.RegisterNormal( combine, "Hold It", "Hold it right there!", "npc/metropolice/vo/holditrightthere.wav" )
Schema.vo.RegisterNormal( combine, "Move Along Repeat", "I said move along.", "npc/metropolice/vo/isaidmovealong.wav" )
Schema.vo.RegisterNormal( combine, "Malcompliance", "Issuing malcompliance citation.", "npc/metropolice/vo/issuingmalcompliantcitation.wav" )
Schema.vo.RegisterNormal( combine, "Keep Moving", "Keep moving!", "npc/metropolice/vo/keepmoving.wav" )
Schema.vo.RegisterNormal( combine, "Lock Position", "All units, lock your position!", "npc/metropolice/vo/lockyourposition.wav" )
Schema.vo.RegisterNormal( combine, "Trouble", "Lookin' for trouble?", "npc/metropolice/vo/lookingfortrouble.wav" )
Schema.vo.RegisterNormal( combine, "Look Out", "Look out!", "npc/metropolice/vo/lookout.wav" )
Schema.vo.RegisterNormal( combine, "Minor Hits", "Minor hits, continuing prosecution.", "npc/metropolice/vo/minorhitscontinuing.wav" )
Schema.vo.RegisterNormal( combine, "Move", "Move!", "npc/metropolice/vo/move.wav" )
Schema.vo.RegisterNormal( combine, "Move Along", "Move along!", "npc/metropolice/vo/movealong3.wav" )
Schema.vo.RegisterNormal( combine, "Move Back", "Move back, right now!", "npc/metropolice/vo/movebackrightnow.wav" )
Schema.vo.RegisterNormal( combine, "Move It", "Move it!", "npc/metropolice/vo/moveit2.wav" )
Schema.vo.RegisterNormal( combine, "Hardpoint", "Moving to hardpoint.", "npc/metropolice/vo/movingtohardpoint.wav" )
Schema.vo.RegisterNormal( combine, "Officer Help", "Officer needs help!", "npc/metropolice/vo/officerneedshelp.wav" )
Schema.vo.RegisterNormal( combine, "Privacy", "Possible level three civil privacy violator here!", "npc/metropolice/vo/possiblelevel3civilprivacyviolator.wav" )
Schema.vo.RegisterNormal( combine, "Judgement", "Suspect prepare to receive civil judgement!", "npc/metropolice/vo/prepareforjudgement.wav" )
Schema.vo.RegisterNormal( combine, "Priority Two", "I have a priority two anti-citizen here!", "npc/metropolice/vo/priority2anticitizenhere.wav" )
Schema.vo.RegisterNormal( combine, "Prosecute", "Prosecute!", "npc/metropolice/vo/prosecute.wav" )
Schema.vo.RegisterNormal( combine, "Amputate Ready", "Ready to amputate!", "npc/metropolice/vo/readytoamputate.wav" )
Schema.vo.RegisterNormal( combine, "Rodger That", "Rodger that!", "npc/metropolice/vo/rodgerthat.wav" )
Schema.vo.RegisterNormal( combine, "Search", "Search!", "npc/metropolice/vo/search.wav" )
Schema.vo.RegisterNormal( combine, "Shit", "Shit!", "npc/metropolice/vo/shit.wav" )
Schema.vo.RegisterNormal( combine, "Sentence Delivered", "Sentence delivered.", "npc/metropolice/vo/sentencedelivered.wav" )
Schema.vo.RegisterNormal( combine, "Sterilize", "Sterilize!", "npc/metropolice/vo/sterilize.wav" )
Schema.vo.RegisterNormal( combine, "Take Cover", "Take cover!", "npc/metropolice/vo/takecover.wav" )
Schema.vo.RegisterNormal( combine, "Restrict", "Restrict!", "npc/metropolice/vo/restrict.wav" )
Schema.vo.RegisterNormal( combine, "Restricted", "Restricted block.", "npc/metropolice/vo/restrictedblock.wav" )
Schema.vo.RegisterNormal( combine, "Second Warning", "This is your second warning!", "npc/metropolice/vo/thisisyoursecondwarning.wav" )
Schema.vo.RegisterNormal( combine, "Verdict", "You want a non-compliance verdict?", "npc/metropolice/vo/youwantamalcomplianceverdict.wav" )
Schema.vo.RegisterNormal( combine, "Backup", "Backup!", "npc/metropolice/vo/backup.wav" )
Schema.vo.RegisterNormal( combine, "Apply", "Apply.", "npc/metropolice/vo/apply.wav" )
Schema.vo.RegisterNormal( combine, "Restriction", "Terminal restriction zone.", "npc/metropolice/vo/terminalrestrictionzone.wav" )
Schema.vo.RegisterNormal( combine, "Complete", "Protection complete.", "npc/metropolice/vo/protectioncomplete.wav" )
Schema.vo.RegisterNormal( combine, "Location Unknown", "Suspect location unknown.", "npc/metropolice/vo/suspectlocationunknown.wav" )
Schema.vo.RegisterNormal( combine, "Can 1", "Pick up that can.", "npc/metropolice/vo/pickupthecan1.wav" )
Schema.vo.RegisterNormal( combine, "Can 2", "Pick... up... the can.", "npc/metropolice/vo/pickupthecan2.wav" )
Schema.vo.RegisterNormal( combine, "Wrap It", "That's it, wrap it up.", "npc/combine_soldier/vo/thatsitwrapitup.wav" )
Schema.vo.RegisterNormal( combine, "Can 3", "I said pickup the can!", "npc/metropolice/vo/pickupthecan3.wav" )
Schema.vo.RegisterNormal( combine, "Can 4", "Now, put it in the trash can.", "npc/metropolice/vo/putitinthetrash1.wav" )
Schema.vo.RegisterNormal( combine, "Can 5", "I said put it in the trash can!", "npc/metropolice/vo/putitinthetrash2.wav" )
Schema.vo.RegisterNormal( combine, "Now Get Out", "Now get out of here!", "npc/metropolice/vo/nowgetoutofhere.wav" )
Schema.vo.RegisterNormal( combine, "Haha", "Haha.", "npc/metropolice/vo/chuckle.wav" )
Schema.vo.RegisterNormal( combine, "X-Ray", "X-Ray!", "npc/metropolice/vo/xray.wav" )
Schema.vo.RegisterNormal( combine, "Patrol", "Patrol!", "npc/metropolice/vo/patrol.wav" )
Schema.vo.RegisterNormal( combine, "Serve", "Serve.", "npc/metropolice/vo/serve.wav" )
Schema.vo.RegisterNormal( combine, "Knocked Over", "You knocked it over, pick it up!", "npc/metropolice/vo/youknockeditover.wav" )
Schema.vo.RegisterNormal( combine, "Watch It", "Watch it!", "npc/metropolice/vo/watchit.wav" )
Schema.vo.RegisterNormal( combine, "Restricted Canals", "Suspect is using restricted canals at...", "npc/metropolice/vo/suspectusingrestrictedcanals.wav" )
Schema.vo.RegisterNormal( combine, "505", "Subject is five-oh-five!", "npc/metropolice/vo/subjectis505.wav" )
Schema.vo.RegisterNormal( combine, "404", "Possible four-zero-oh here!", "npc/metropolice/vo/possible404here.wav" )
Schema.vo.RegisterNormal( combine, "Vacate", "Vacate citizen!", "npc/metropolice/vo/vacatecitizen.wav" )
Schema.vo.RegisterNormal( combine, "Escapee", "Priority two escapee.", "npc/combine_soldier/vo/prioritytwoescapee.wav" )
Schema.vo.RegisterNormal( combine, "Objective", "Priority one objective.", "npc/combine_soldier/vo/priority1objective.wav" )
Schema.vo.RegisterNormal( combine, "Payback", "Payback.", "npc/combine_soldier/vo/payback.wav" )
Schema.vo.RegisterNormal( combine, "Got Him Now", "Affirmative, we got him now.", "npc/combine_soldier/vo/affirmativewegothimnow.wav" )
Schema.vo.RegisterNormal( combine, "Antiseptic", "Antiseptic.", "npc/combine_soldier/vo/antiseptic.wav" )
Schema.vo.RegisterNormal( combine, "Cleaned", "Cleaned.", "npc/combine_soldier/vo/cleaned.wav" )
Schema.vo.RegisterNormal( combine, "Engaged Cleanup", "Engaged in cleanup.", "npc/combine_soldier/vo/engagedincleanup.wav" )
Schema.vo.RegisterNormal( combine, "Engaging", "Engaging.", "npc/combine_soldier/vo/engaging.wav" )
Schema.vo.RegisterNormal( combine, "Full Response", "Executing full response.", "npc/combine_soldier/vo/executingfullresponse.wav" )
Schema.vo.RegisterNormal( combine, "Heavy Resistance", "Overwatch advise, we have heavy resistance.", "npc/combine_soldier/vo/heavyresistance.wav" )
Schema.vo.RegisterNormal( combine, "Inbound", "Inbound.", "npc/combine_soldier/vo/inbound.wav" )
Schema.vo.RegisterNormal( combine, "Lost Contact", "Lost contact!", "npc/combine_soldier/vo/lostcontact.wav" )
Schema.vo.RegisterNormal( combine, "Move In", "Move in!", "npc/combine_soldier/vo/movein.wav" )
Schema.vo.RegisterNormal( combine, "Harden Position", "Harden that position!", "npc/combine_soldier/vo/hardenthatposition.wav" )
Schema.vo.RegisterNormal( combine, "Go Sharp", "Go sharp, go sharp!", "npc/combine_soldier/vo/gosharpgosharp.wav" )
Schema.vo.RegisterNormal( combine, "Delivered", "Delivered.", "npc/combine_soldier/vo/delivered.wav" )
Schema.vo.RegisterNormal( combine, "Necrotics Inbound", "Necrotics, inbound!", "npc/combine_soldier/vo/necroticsinbound.wav" )
Schema.vo.RegisterNormal( combine, "Necrotics", "Necrotics.", "npc/combine_soldier/vo/necrotics.wav" )
Schema.vo.RegisterNormal( combine, "Outbreak", "Outbreak!", "npc/combine_soldier/vo/outbreak.wav" )
Schema.vo.RegisterNormal( combine, "Copy That", "Copy that.", "npc/combine_soldier/vo/copythat.wav" )
Schema.vo.RegisterNormal( combine, "Outbreak Status", "Outbreak status is code.", "npc/combine_soldier/vo/outbreakstatusiscode.wav" )
Schema.vo.RegisterNormal( combine, "Overwatch", "Overwatch!", "npc/combine_soldier/vo/overwatch.wav" )
Schema.vo.RegisterNormal( combine, "Preserve", "Preserve!", "npc/metropolice/vo/preserve.wav" )
Schema.vo.RegisterNormal( combine, "Pressure", "Pressure!", "npc/metropolice/vo/pressure.wav" )
Schema.vo.RegisterNormal( combine, "Phantom", "Phantom!", "npc/combine_soldier/vo/phantom.wav" )
Schema.vo.RegisterNormal( combine, "Stinger", "Stinger!", "npc/combine_soldier/vo/stinger.wav" )
Schema.vo.RegisterNormal( combine, "Shadow", "Shadow!", "npc/combine_soldier/vo/shadow.wav" )
Schema.vo.RegisterNormal( combine, "Savage", "Savage!", "npc/combine_soldier/vo/savage.wav" )
Schema.vo.RegisterNormal( combine, "Reaper", "Reaper!", "npc/combine_soldier/vo/reaper.wav" )
Schema.vo.RegisterNormal( combine, "Victor", "Victor!", "npc/metropolice/vo/victor.wav" )
Schema.vo.RegisterNormal( combine, "Sector", "Sector!", "npc/metropolice/vo/sector.wav" )
Schema.vo.RegisterNormal( combine, "Inject", "Inject!", "npc/metropolice/vo/inject.wav" )
Schema.vo.RegisterNormal( combine, "Dagger", "Dagger!", "npc/combine_soldier/vo/dagger.wav" )
Schema.vo.RegisterNormal( combine, "Blade", "Blade!", "npc/combine_soldier/vo/blade.wav" )
Schema.vo.RegisterNormal( combine, "Razor", "Razor!", "npc/combine_soldier/vo/razor.wav" )
Schema.vo.RegisterNormal( combine, "Nomad", "Nomad!", "npc/combine_soldier/vo/nomad.wav" )
Schema.vo.RegisterNormal( combine, "Judge", "Judge!", "npc/combine_soldier/vo/judge.wav" )
Schema.vo.RegisterNormal( combine, "Ghost", "Ghost!", "npc/combine_soldier/vo/ghost.wav" )
Schema.vo.RegisterNormal( combine, "Sword", "Sword!", "npc/combine_soldier/vo/sword.wav" )
Schema.vo.RegisterNormal( combine, "Union", "Union!", "npc/metropolice/vo/union.wav" )
Schema.vo.RegisterNormal( combine, "Helix", "Helix!", "npc/combine_soldier/vo/helix.wav" )
Schema.vo.RegisterNormal( combine, "Storm", "Storm!", "npc/combine_soldier/vo/storm.wav" )
Schema.vo.RegisterNormal( combine, "Spear", "Spear!", "npc/combine_soldier/vo/spear.wav" )
Schema.vo.RegisterNormal( combine, "Vamp", "Vamp!", "npc/combine_soldier/vo/vamp.wav" )
Schema.vo.RegisterNormal( combine, "Nova", "Nova!", "npc/combine_soldier/vo/nova.wav" )
Schema.vo.RegisterNormal( combine, "Mace", "Mace!", "npc/combine_soldier/vo/mace.wav" )
Schema.vo.RegisterNormal( combine, "Grid", "Grid!", "npc/combine_soldier/vo/grid.wav" )
Schema.vo.RegisterNormal( combine, "Kilo", "Kilo!", "npc/combine_soldier/vo/kilo.wav" )
Schema.vo.RegisterNormal( combine, "Echo", "Echo!", "npc/combine_soldier/vo/echo.wav" )
Schema.vo.RegisterNormal( combine, "Dash", "Dash!", "npc/combine_soldier/vo/dash.wav" )
Schema.vo.RegisterNormal( combine, "Apex", "Apex!", "npc/combine_soldier/vo/apex.wav" )
Schema.vo.RegisterNormal( combine, "Jury", "Jury!", "npc/metropolice/vo/jury.wav" )
Schema.vo.RegisterNormal( combine, "King", "King!", "npc/metropolice/vo/king.wav" )
Schema.vo.RegisterNormal( combine, "Lock", "Lock!", "npc/metropolice/vo/lock.wav" )
Schema.vo.RegisterNormal( combine, "Vice", "Vice!", "npc/metropolice/vo/vice.wav" )
Schema.vo.RegisterNormal( combine, "Zero", "Zero!", "npc/metropolice/vo/zero.wav" )
Schema.vo.RegisterNormal( combine, "Zone", "Zone!", "npc/metropolice/vo/zone.wav" )


//Schema.vo.RegisterNormal( citizen, "Sweeping", "Sweeping for suspect.", "npc/metropolice/hiding02.wav" )