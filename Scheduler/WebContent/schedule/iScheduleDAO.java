package Schedule;

import java.util.List;

public interface iScheduleDAO {
	public List<ScheduleDTO> getAllSchedulList();
	public boolean addSchedule(ScheduleDTO dto);
	public ScheduleDTO findschduel(int seq);
	public boolean updateSchedule(ScheduleDTO dto);
	public boolean deleteSchedule(int seq);
}
