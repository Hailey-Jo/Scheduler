package pds;

import java.util.List;

public interface iPdsDao {
	
	public boolean write(PdsDto pds);
	public List<PdsDto> getPdsList(String id);
	public boolean downloadCount(int seq);
	public boolean pdsReadCount(int seq);
	public PdsDto getPDS(int seq);
	public boolean pdsDel(int seq);
	
}
