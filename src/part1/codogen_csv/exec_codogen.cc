#include "exec_codogen.h"

#include <chrono>
#include <cstdlib>
#include <cstring>
#include <filesystem>
#include <fstream>
#include <iostream>
#include <map>
#include <random>
#include <sstream>

auto seed = std::chrono::system_clock::now().time_since_epoch().count();
std::mt19937 gen(seed);
std::uniform_int_distribution<int> dist(0, 999999);

int main() {
  srand(time(NULL));
  cg::GenerateTasks();
  cg::GeneratePeers();
  cg::GenerateFriends();
  std::set<std::string> visited = cg::GenerateTimeTracking();
  std::vector<cg::Check> checks = cg::GenerateChecksStructs();
  // -----------------------------------------
  // ПРИМЕР ДОБАВЛЕНИЯ СВОИХ ПИРОВ И ПРОВЕРОК:
  // -----------------------------------------
  cg::CreatePeer("abobator", "1993-06-25");
  cg::CreatePeer("bobagovr", "1989-07-19");
  // -----------------------------------------
  cg::Check to_add_1{.project_owner = "abobator",
                     .checker = "bobagovr",
                     .task_idx = 1,
                     .check_date = "2023-05-06",
                     .p2p_check_state = cg::kFailure,
                     .p2p_check_time = "09:12:34",
                     .sum_transfered_from_to = 10,
                     .project_owner_recommends_checker = true,
                     .verter_check_state = cg::kFailure,
                     .verter_check_time = "11:13:35",
                     .xp_amount = 0};
  // -----------------------------------------
  cg::Check to_add_2{.project_owner = "bobagovr",
                     .checker = "abobator",
                     .task_idx = 1,
                     .check_date = "2023-06-07",
                     .p2p_check_state = cg::kSuccess,
                     .p2p_check_time = "12:01:33",
                     .sum_transfered_from_to = 5,
                     .project_owner_recommends_checker = false,
                     .verter_check_state = cg::kFailure,
                     .verter_check_time = "14:19:01",
                     .xp_amount = 95};
  // -----------------------------------------
  checks.push_back(to_add_1);
  checks.push_back(to_add_2);
  // -----------------------------------------
  cg::RaspihChecksToFiles(checks);
  return 0;
}

namespace cg {
using str = std::string;

constexpr int kPeersToGenerate = 100;

// kFriendsConnsToGen should be less than half of kPeersToGenerate:
constexpr int kFriendsConnsToGen = (kPeersToGenerate / 2) - 2;

// 12 tasks:
const std::vector<str> kTasks = {"-",
                                 "C3_SimpleBashUtils",
                                 "C2_s21_stringplus",
                                 "C5_s21_decimal",
                                 "C6_s21_matrix",
                                 "C7_SmartCalc_v1.0",
                                 "C8_3DViewer_v1.0",
                                 "CPP1_s21_matrixplus",
                                 "CPP2_s21_containers",
                                 "CPP3_SmartCalc_v2.0",
                                 "CPP4_3DViewer_v2.0",
                                 "A1_Maze",
                                 "A2_SimpleNavigator_v1.0"};

const std::vector<std::pair<int, int>> kTasksXP = {
    {0, 0},       // "-"
    {280, 350},   // "C3_SimpleBashUtils"
    {600, 750},   // "C2_s21_stringplus"
    {280, 350},   // "C5_s21_decimal"
    {160, 200},   // "C6_s21_matrix"
    {520, 650},   // "C7_SmartCalc_v1.0"
    {840, 1050},  // "C8_3DViewer_v1.0"
    {240, 300},   // "CPP1_s21_matrixplus"
    {360, 450},   // "CPP2_s21_containers"
    {560, 700},   // "CPP3_SmartCalc_v2.0"
    {680, 850},   // "CPP4_3DViewer_v2.0"
    {320, 400},   // "A1_Maze"
    {400, 500},   // "A2_SimpleNavigator_v1.0"
};

void GenerateTasks() {
  ClearAndCheckFile("../csv/tasks.csv");
  std::ofstream outfile("../csv/tasks.csv", std::ios::out | std::ios::app);
  outfile << "C3_SimpleBashUtils,,350" << std::endl;
  outfile << "C2_s21_stringplus,C3_SimpleBashUtils,750" << std::endl;
  outfile << "C5_s21_decimal,C3_SimpleBashUtils,350" << std::endl;
  outfile << "C6_s21_matrix,C5_s21_decimal,200" << std::endl;
  outfile << "C7_SmartCalc_v1.0,C6_s21_matrix,650" << std::endl;
  outfile << "C8_3DViewer_v1.0,C7_SmartCalc_v1.0,1050" << std::endl;
  outfile << "CPP1_s21_matrixplus,C8_3DViewer_v1.0,300" << std::endl;
  outfile << "CPP2_s21_containers,CPP1_s21_matrixplus,450" << std::endl;
  outfile << "CPP3_SmartCalc_v2.0,CPP2_s21_containers,700" << std::endl;
  outfile << "CPP4_3DViewer_v2.0,CPP3_SmartCalc_v2.0,850" << std::endl;
  outfile << "A1_Maze,CPP4_3DViewer_v2.0,400" << std::endl;
  outfile << "A2_SimpleNavigator_v1.0,A1_Maze,500" << std::endl;
  outfile.close();  // close the file
}

str GenerateName() {
  str soglas = "bdgkmnvz";  // no t,s
  str glas = "aeou";
  str return_string = "";
  for (int i = 0; i < 8; ++i) {
    if (i % 2) {
      return_string.push_back(soglas[dist(gen) % soglas.length()]);
    } else {
      return_string.push_back(glas[dist(gen) % glas.length()]);
    }
  }
  return return_string;
}

void GeneratePeers() {
  ClearAndCheckFile("../csv/peers.csv");
  std::ofstream outfile("../csv/peers.csv", std::ios::out | std::ios::app);
  // outfile << "Nickname,Birthday," << std::endl;
  std::set<str> existing_peers;
  for (int i = 0; i < kPeersToGenerate; ++i) {
    str name = "";
    do {
      name = GenerateName();
    } while (existing_peers.count(name) > 0);
    int birth_day = dist(gen) % 28 + 1;
    int birth_month = dist(gen) % 12 + 1;
    int birth_year = dist(gen) % 41 + 1960;
    str birth_day_str = std::to_string(birth_day);
    birth_day_str = ZAdd(birth_day_str);
    str birth_month_str = std::to_string(birth_month);
    birth_month_str = ZAdd(birth_month_str);
    outfile << name << "," << birth_year << "-" << birth_month_str << "-"
            << birth_day_str << std::endl;
  }
  outfile.close();  // close the file
}

void CreatePeer(str Name, str Birthdate) {
  std::ofstream out_file("../csv/peers.csv", std::ios::out | std::ios::app);
  out_file << Name << "," << Birthdate << std::endl;
  out_file.close();
}

void GenerateFriends() {
  ClearAndCheckFile("../csv/friends.csv");
  std::ofstream out_file("../csv/friends.csv", std::ios::out | std::ios::app);
  auto names_vector = GetNamesFromPeers();
  // out_file << "Peer1,Peer2," << std::endl;

  int writen_lines_counter = 1;
  int i = 1;
  while (i < (names_vector.size() / 2) && (i < kFriendsConnsToGen + 1)) {
    int num_fr_for_peer = (dist(gen) % (names_vector.size() / 4)) + 8;
    for (int j = 1; (j < (names_vector.size() / num_fr_for_peer)) &&
                    (j < (names_vector.size() / 2));
         ++j) {
      out_file << names_vector[i] << ","
               << names_vector[names_vector.size() - j] << std::endl;
      ++writen_lines_counter;
    }
    ++i;
  }
  out_file.close();
}

// **-** always logged in
std::set<str> GenerateTimeTracking() {
  ClearAndCheckFile("../csv/time_tracking.csv");
  std::ofstream out_file("../csv/time_tracking.csv",
                         std::ios::out | std::ios::app);
  std::set<str> visited;
  auto names = GetNamesFromPeers();
  // out_file << "Peer,Date,Time,State," << std::endl;
  std::map<int, int> monthDays = {{1, 31}, {2, 28},  {3, 31},  {4, 30},
                                  {5, 31}, {6, 30},  {7, 31},  {8, 31},
                                  {9, 30}, {10, 31}, {11, 30}, {12, 31}};
  for (const auto& [month, days] : monthDays) {
    TimeTrackingMonth(names, visited, out_file, month, days);
  }
  out_file.close();
  return visited;
}

void TimeTrackingMonth(std::vector<str>& names, std::set<str>& visited,
                       std::ofstream& out_file, int month_num,
                       int max_day_in_month) {
  for (int i = 1; i < (names.size()); ++i) {
    if (dist(gen) % 5 == 1) {
      for (int j = 1; j < max_day_in_month + 1; ++j) {
        if (dist(gen) % 8 == 1) {
          FillDateForTimeTracking(1, i, j, 9, 0, out_file, names, month_num);
          FillDateForTimeTracking(2, i, j, 14, 10, out_file, names, month_num);
          visited.insert(names[i]);
        } else if (dist(gen) % 8 == 3) {  // multi-visit
          FillDateForTimeTracking(1, i, j, 4, 0, out_file, names, month_num);
          FillDateForTimeTracking(2, i, j, 4, 6, out_file, names, month_num);
          FillDateForTimeTracking(1, i, j, 4, 12, out_file, names, month_num);
          FillDateForTimeTracking(2, i, j, 4, 18, out_file, names, month_num);
          visited.insert(names[i]);
        }
      }
    }
  }
}

std::vector<Check> GenerateChecksStructs() {
  auto names = GetNamesFromPeers();
  std::vector<Check> checks;
  checks.reserve(1000);
  Check check_to_push;
  // speedrunners:
  int i = 1;
  for (; i < ((dist(gen) % (names.size() / 4)) + 8); ++i) {
    int first_ch_shift = dist(gen) % 5;
    for (int j = 1; j < (kTasks.size()); ++j) {
      if ((dist(gen) % 10 < 3) && (j > 3)) break;
      str checker = "";
      if ((i + j) < names.size() - 1) checker = names[i + j];
      if ((i + j) >= names.size() - 1) break;
      if (checker == names[i]) break;
      str check_date = "2023-01-" + std::to_string(10 + first_ch_shift +
                                                   (j + -(dist(gen) % 2)));
      int project_check_hour = dist(gen) % 20;
      str p2p_check_time = FillTime(project_check_hour, 0, 1);
      bool recommends = false;
      if (!(dist(gen) % 2)) recommends = true;
      str verter_check_time = FillTime(project_check_hour + 2, 0, 1);
      int xp_amount = kTasksXP[j].first +
                      (rand() % (kTasksXP[j].second - kTasksXP[j].first + 1));
      // raspih:
      check_to_push.project_owner = names[i];
      check_to_push.checker = checker;
      check_to_push.task_idx = j;
      check_to_push.check_date = check_date;
      check_to_push.p2p_check_state = kSuccess;
      check_to_push.p2p_check_time = p2p_check_time;
      check_to_push.sum_transfered_from_to = 1;
      check_to_push.project_owner_recommends_checker = recommends;
      check_to_push.verter_check_state = kSuccess;
      check_to_push.verter_check_time = verter_check_time;
      check_to_push.xp_amount = xp_amount;
      //
      // printCheck(check_to_push);
      checks.push_back(check_to_push);
    }
  }
  // normal dudes:
  for (; i < names.size(); ++i) {
    for (int j = 1; j < (kTasks.size()); ++j) {
      if (dist(gen) % 10 < 3) break;
      str checker = "";
      if ((i + j) < names.size() - 1) checker = names[i + j];
      if ((i + j) >= names.size() - 1) break;
      if (checker == names[i]) break;
      str check_date = "2023-" + ZAdd(std::to_string(j)) + "-" +
                       ZAdd(std::to_string((dist(gen) % 28) + 1));
      int project_check_hour = dist(gen) % 20;
      str p2p_check_time = FillTime(project_check_hour, 0, 1);
      bool recommends = false;
      if (!(dist(gen) % 2)) recommends = true;
      str verter_check_time = FillTime(project_check_hour + 2, 0, 1);
      int xp_amount = kTasksXP[j].first +
                      (rand() % (kTasksXP[j].second - kTasksXP[j].first + 1));
      // raspih:
      check_to_push.project_owner = names[i];
      check_to_push.checker = checker;
      check_to_push.task_idx = j;
      check_to_push.check_date = check_date;
      check_to_push.p2p_check_state = kSuccess;
      check_to_push.p2p_check_time = p2p_check_time;
      check_to_push.sum_transfered_from_to = 1;
      check_to_push.project_owner_recommends_checker = recommends;
      check_to_push.verter_check_state = kSuccess;
      check_to_push.verter_check_time = verter_check_time;
      check_to_push.xp_amount = xp_amount;
      //
      // printCheck(check_to_push);
      checks.push_back(check_to_push);
    }
  }
  return checks;
}

std::string PlusHour(std::string timeStr) {
  int hours = std::stoi(timeStr.substr(0, 2));
  int minutes = std::stoi(timeStr.substr(3, 2));
  int seconds = std::stoi(timeStr.substr(6, 2));
  hours = (hours + 1) % 24;
  char buffer[9];
  std::snprintf(buffer, sizeof(buffer), "%02d:%02d:%02d", hours, minutes,
                seconds);
  return std::string(buffer);
}

std::string PlusMinute(std::string timeStr) {
  int hours = std::stoi(timeStr.substr(0, 2));
  int minutes = std::stoi(timeStr.substr(3, 2));
  int seconds = std::stoi(timeStr.substr(6, 2));
  minutes = (minutes + 1) % 60;
  if (minutes == 0) hours = (hours + 1) % 24;
  char buffer[9];
  std::snprintf(buffer, sizeof(buffer), "%02d:%02d:%02d", hours, minutes,
                seconds);
  return std::string(buffer);
}

void RaspihChecksToFiles(std::vector<cg::Check> checks) {
  // Checks:
  ClearAndCheckFile("../csv/checks.csv");
  std::ofstream out_Checks("../csv/checks.csv", std::ios::out | std::ios::app);
  // out_Checks << "Peer,Task,Date," << std::endl;
  // ------
  // P2P:
  ClearAndCheckFile("../csv/p2p.csv");
  std::ofstream out_P2P("../csv/p2p.csv", std::ios::out | std::ios::app);
  // out_P2P << "Check,CheckingPeer,State,Time," << std::endl;
  // ------
  // Verter:
  ClearAndCheckFile("../csv/verter.csv");
  std::ofstream out_Verter("../csv/verter.csv", std::ios::out | std::ios::app);
  // out_Verter << "Check,State,Time," << std::endl;
  // ------
  // XP:
  ClearAndCheckFile("../csv/xp.csv");
  std::ofstream out_XP("../csv/xp.csv", std::ios::out | std::ios::app);
  // out_XP << "Check,XPAmount," << std::endl;
  // ------
  // TransferredPoints:
  ClearAndCheckFile("../csv/transferred_points.csv");
  std::ofstream out_TransferredPoints("../csv/transferred_points.csv",
                                      std::ios::out | std::ios::app);
  // out_TransferredPoints << "CheckingPeer,CheckedPeer,PointsAmount,"
  //                       << std::endl;
  // ------
  // Recommendations:
  ClearAndCheckFile("../csv/recommendations.csv");
  std::ofstream out_Recommendations("../csv/recommendations.csv",
                                    std::ios::out | std::ios::app);
  // out_Recommendations << "Peer,RecommendedPeer," << std::endl;
  // -------------
  // -- RASPIH: --
  // -------------
  int line_counter_Checks = 1;
  int line_counter_P2P = 1;
  int line_counter_Verter = 1;
  int line_counter_Trans = 1;
  int line_counter_Recom = 1;
  for (int i = 0; i < checks.size(); ++i) {
    out_Checks << checks[i].project_owner << "," << kTasks[checks[i].task_idx]
               << "," << checks[i].check_date << std::endl;
    ++line_counter_Checks;

    out_P2P << i + 1 << "," << checks[i].checker << ",Start,"
            << checks[i].p2p_check_time << std::endl;
    ++line_counter_P2P;
    out_P2P << i + 1 << "," << checks[i].checker << ","
            << ToString(checks[i].p2p_check_state) << ","
            << PlusHour(checks[i].p2p_check_time) << std::endl;
    ++line_counter_P2P;

    out_Verter << i + 1 << ",Start," << checks[i].verter_check_time
               << std::endl;
    ++line_counter_Verter;
    out_Verter << i + 1 << "," << ToString(checks[i].verter_check_state) << ","
               << PlusMinute(checks[i].verter_check_time) << std::endl;
    ++line_counter_Verter;

    out_XP << i + 1 << "," << checks[i].xp_amount << std::endl;

    out_TransferredPoints << checks[i].checker << "," << checks[i].project_owner
                          << "," << checks[i].sum_transfered_from_to
                          << std::endl;
    ++line_counter_Trans;

    if (checks[i].project_owner_recommends_checker) {
      out_Recommendations << checks[i].project_owner << "," << checks[i].checker
                          << std::endl;
      ++line_counter_Recom;
    }
  }
  out_Checks.close();
  out_P2P.close();
  out_Verter.close();
  out_XP.close();
  out_TransferredPoints.close();
  out_Recommendations.close();
}

// HELPERS:
// --------
void FillDateForTimeTracking(int state, int i, int j, int mod_hour,
                             int plus_hour, std::ofstream& out_file,
                             std::vector<std::string>& names_vector,
                             int month_number) {
  static int counter = 1;
  out_file << names_vector[i] << ","
           << "2023-" << ZAdd(std::to_string(month_number)) << "-"
           << ZAdd(std::to_string(j)) << ","
           << FillTime(mod_hour, plus_hour, false) << ","
           << std::to_string(state) << std::endl;
  ++counter;
}

str FillTime(int mod_hour, int plus_hour, bool force_time) {
  str hour = "";
  if (force_time) {
    str temp_str = std::to_string(mod_hour);
    hour = ZAdd(temp_str);
  } else {
    hour = ZAdd(std::to_string((dist(gen) % mod_hour) + plus_hour));
  }
  return hour + ":" + ZAdd(std::to_string(((dist(gen) % 50) + 1))) + ":" +
         ZAdd(std::to_string(((dist(gen) % 60) + 1)));
}

std::vector<str> GetNamesFromPeers() {
  std::ifstream peer_file("../csv/peers.csv");
  std::vector<str> names_vector;
  str name = "";
  int i = 0;
  while (peer_file >> name) {
    names_vector.push_back(name.substr(0, name.find(',')));
    ++i;
  }
  peer_file.close();
  return names_vector;
}

void ClearAndCheckFile(str file_name) {
  if (std::filesystem::exists(file_name)) {
    std::ofstream file_to_clear(file_name);
    if (!file_to_clear.is_open()) {
      std::cerr << "Error: could not open file for writing." << std::endl;
      return;
    }
    file_to_clear.open(file_name, std::ofstream::out | std::ofstream::trunc);
  } else {
    std::cerr << "Error: file does not exist." << std::endl;
  }
}

str ZAdd(const str& input) {
  str temp = input;
  if (temp.size() == 1) temp.insert(0, "0");
  return temp;
}

template <typename T>
void printProperty(const str& name, const T& prop) {
  std::cout << name << ": " << prop << std::endl;
}

void printCheck(const Check& check) {
  std::cout << '\n';
  printProperty("project_owner", check.project_owner);
  printProperty("checker", check.checker);
  printProperty("task_idx", check.task_idx);
  printProperty("date", check.check_date);
  printProperty("p2p_check_state", check.p2p_check_state);
  printProperty("p2p_check_time", check.p2p_check_time);

  auto sum_transfers = check.sum_transfered_from_to;
  printProperty("sum_transfers", sum_transfers);
  printProperty("project_owner_recommends_checker",
                check.project_owner_recommends_checker);
  printProperty("verter_check_state", check.verter_check_state);
  printProperty("verter_check_time", check.verter_check_time);
  printProperty("xp_amount", check.xp_amount);
}

}  // namespace cg