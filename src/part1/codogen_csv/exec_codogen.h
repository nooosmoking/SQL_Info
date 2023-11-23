#ifndef SQL2_INFO21_V1_0_CSV_CODOGEN_EXEC_CODOGEN_H_
#define SQL2_INFO21_V1_0_CSV_CODOGEN_EXEC_CODOGEN_H_

#include <set>
#include <string>
#include <vector>

namespace cg {

enum kCheckState {
  kFailure,
  kSuccess,
  kStarted,
};

inline std::string ToString(kCheckState v) {
  switch (v) {
    case kFailure:
      return "Failure";
    case kSuccess:
      return "Success";
    case kStarted:
      return "Start";
    default:
      return "ErrorInEnumConversionToString";
  }
}

typedef struct Check_t {
  // MultiTable:
  std::string project_owner;
  std::string checker;
  // Checks:
  int task_idx;
  std::string check_date;
  // P2P:
  kCheckState p2p_check_state;
  std::string p2p_check_time;
  // TranferredPoints:
  int sum_transfered_from_to;
  // Recommendations:
  bool project_owner_recommends_checker;
  // Verter:
  kCheckState verter_check_state;
  std::string verter_check_time;
  // XP:
  int xp_amount;
} Check;

void NumerateLinesInAFile(const std::string& input_file_name);
void GenerateTasks();
std::string GenerateName();
void GeneratePeers();
void CreatePeer(std::string Name, std::string Birthdate);
void GenerateFriends();
std::set<std::string> GenerateTimeTracking();
void TimeTrackingMonth(std::vector<std::string>& names,
                       std::set<std::string>& visited, std::ofstream& out_file,
                       int month_num, int max_day_in_month);
std::set<std::string> GenerateChecks();
std::vector<Check> GenerateChecksStructs();
void FillDateForTimeTracking(int state, int i, int j, int mod_hour,
                             int plus_hour, std::ofstream& out_file,
                             std::vector<std::string>& names_vector,
                             int month_number);
std::string FillTime(int mod_hour, int plus_hour, bool force_time);
std::string PlusHour(std::string timeStr);
std::string PlusMinute(std::string timeStr);
std::vector<std::string> GetNamesFromPeers();
void RaspihChecksToFiles(std::vector<cg::Check> checks);
void ClearAndCheckCheckRelevantCsvs();
void printCheck(const Check& check);
std::string ZAdd(const std::string& input);
void ClearAndCheckFile(std::string file_name);
}  // namespace cg
#endif  // SQL2_INFO21_V1_0_CSV_CODOGEN_EXEC_CODOGEN_H_