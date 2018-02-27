package Schedule;

import java.util.List;

public interface iScheduleDAO {
	public List<ScheduleDTO> getAllSchedulList();
	public boolean addSchedule(ScheduleDTO dto);
}
