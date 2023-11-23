// void FillCheckStruct(Check& check_to_fill, str project_owner, str checker,
//                      int check_id, int task_idx, str check_date,
//                      cg::kCheckState p2p_check_state, str p2p_check_time,
//                      int all_time_trans, bool recommends,
//                      cg::kCheckState verter_check_state, str
//                      verter_check_time, int xp_amount) {
//   check_to_fill.project_owner = project_owner;
//   check_to_fill.checker = checker;
//   check_to_fill.check_id = check_id;
//   check_to_fill.task_idx = task_idx;
//   check_to_fill.check_date = check_date;
//   check_to_fill.p2p_check_state = p2p_check_state;
//   check_to_fill.p2p_check_time = p2p_check_time;
//   check_to_fill.alltime_transferd_points_from_owner_to_checker =
//   all_time_trans; check_to_fill.project_owner_recommends_checker =
//   recommends; check_to_fill.verter_check_state = verter_check_state;
//   check_to_fill.verter_check_time = verter_check_time;
//   check_to_fill.xp_amount = xp_amount;
// }

// OLD GENERATE CHECKS:

// std::set<str> GenerateChecks() {
//   ClearAndCheckFile("./csv/Checks.csv");
//   std::ofstream out_file("./csv/Checks.csv", std::ios::out | std::ios::app);
//   auto names = GetNamesFromPeers();
//   out_file << "Peer,Task,Date," << std::endl;
//   std::set<str> active_peers;
//   // speedrunners:
//   int i = 1;
//   for (; i < ((dist(gen) % (names.size() / 4)) + 8); ++i) {
//     int first_check_shift = dist(gen) % 5;
//     for (int j = 1; j < (kTasks.size()); ++j) {
//       if ((dist(gen) % 10 < 3) && (j > 3)) break;
//       active_peers.insert(names[i]);
//       out_file << names[i] << "," << kTasks[j] << ","
//                << "2023-01-" << 10 + first_check_shift + (j + -(dist(gen) %
//                2))
//                << "," << std::endl;
//     }
//   }
//   // normal dudes:
//   for (; i < names.size(); ++i) {
//     int first_check_shift = dist(gen) % 5;
//     if (dist(gen) % 10 == 1) continue;
//     for (int j = 1; j < (kTasks.size()); ++j) {
//       if (dist(gen) % 10 < 2) break;
//       active_peers.insert(names[i]);
//       out_file << names[i] << "," << kTasks[j] << ","
//                << "2023-" << ZAdd(std::to_string(j)) << "-"
//                << ZAdd(std::to_string((dist(gen) % 28 + 1))) << ","
//                << std::endl;
//     }
//   }
//   out_file.close();
//   return active_peers;
// }

// typedef struct Check_t {
//   str project_owner;
//   str checker;
//   int check_id;
//   int task_idx;
//   str date;
//   kCheckState p2p_check_state;
//   str p2p_check_time;
//   int all_time_transferred_points_from_project_owner_to_checker;
//   bool project_owner_recommends_checker;
//   kCheckState verter_check_state;
//   str verter_check_time;
//   int xp_amount;
// } Check;

// void FillCheckStruct(Check& check_to_fill, str project_owner, str checker,
//                      int check_id, int task_idx, str check_date,
//                      cg::kCheckState p2p_check_state, str p2p_check_time,
//                      int all_time_trans, bool recommends,
//                      cg::kCheckState verter_check_state, str
//                      verter_check_time, int xp_amount) {
//   check_to_fill.project_owner = project_owner;
//   check_to_fill.checker = checker;
//   check_to_fill.check_id = check_id;
//   check_to_fill.task_idx = task_idx;
//   check_to_fill.check_date = check_date;
//   check_to_fill.p2p_check_state = p2p_check_state;
//   check_to_fill.p2p_check_time = p2p_check_time;
//   check_to_fill.all_time_transferred_points_from_project_owner_to_checker =
//       all_time_trans;
//   check_to_fill.project_owner_recommends_checker = recommends;
//   check_to_fill.verter_check_state = verter_check_state;
//   check_to_fill.verter_check_time = verter_check_time;
//   check_to_fill.xp_amount = xp_amount;
// }