package pds;

public class PageingUtil {
	public static PagingBean setPagingInfo(PagingBean paging) {
		paging.setCountPerPage(10);
		paging.setBlockCount(10);
		
		paging.setStartNum(paging.getTotalCount() 
				- ((paging.getNowPage()-1) * paging.getCountPerPage()));
		
		/*
		 paging.getTotalCount() : 올린 글의 수
		 12개
		 
		 12
		 	1페이지
		 	
		 		12 - ( 1 - 1 ) * 10 = 12
		 		
		 	2페이지
		 		12 - ( 2 - 1 ) * 10 = 2
		 */
		
		System.out.println("paging.getTotalCount() ==" + paging.getTotalCount() );
		System.out.println("paging.getNowPage() ==" + paging.getNowPage() );
		System.out.println("paging.getCountPerPage() ==" + paging.getCountPerPage() );
		System.out.println("paging.getStartNum() ==" + paging.getStartNum() );
		
		return paging;
	}
}
