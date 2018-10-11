public class PaginationUtil {

	private static final Integer DEFAULT_ITEM_SIZE = 10;
	private static final Integer MAX_ITEM_SIZE = 100;

	public Integer previousPage { get; private set; }
	public Integer firstPage  { get; private set; }
	public List<Integer> midPages  { get; private set; }
	public Integer lastPage  { get; private set; }
	public Integer nextPage  { get; private set; }

	public PaginationUtil(Integer currentPage, Integer totalItemNumber, Integer itemPerPage, Integer buttonsToShow) {

		midPages = new List<Integer>();
		Integer totalPageNumber = (itemPerPage > 0 && totalItemNumber > 0) ? (totalItemNumber - 1) / itemPerPage + 1 : 1;

		if (totalPageNumber > 1) {
			if (currentPage < 1) {
				currentPage = 1;
			} else if (currentPage > totalPageNumber) {
				currentPage = totalPageNumber;
			}

			buttonsToShow = Math.max(buttonsToShow, 3);

			Integer offsetMid = Math.min(totalPageNumber - 1, 2 * (buttonsToShow / 2) + 1);
			Integer firstMid = Math.max(1, currentPage - offsetMid / 2);
			Integer lastMid = Math.min(totalPageNumber, currentPage + offsetMid / 2);

			if (firstMid <= 2) {
				firstMid = 1;
			} else {
				firstPage = 1;
			}

			if (lastMid >= totalPageNumber - 1) {
				lastMid = totalPageNumber;
			} else {
				lastPage = totalPageNumber;
			}

			for (Integer i = firstMid; i <= lastMid; i++) {
				midPages.add(i);
			}

			previousPage = (currentPage > 1) ? currentPage - 1 : null;
			nextPage = (currentPage < totalPageNumber) ? currentPage + 1 : null;
		} else {
			midPages.add(1);
		}
	}

	public static Integer parsePage(String page) {
		if (page != null && page.isNumeric() && Integer.valueOf(page) > 0) {
			return Integer.valueOf(page);
		}
		return 1;
	}

	public static Integer parseSize(String itemPerPage) {
		Integer tmpItemPerPage = DEFAULT_ITEM_SIZE;
		if (itemPerPage != null && itemPerPage.isNumeric() && Integer.valueOf(itemPerPage) > 0) {
			tmpItemPerPage = Integer.valueOf(itemPerPage);
		}
		return Math.min(tmpItemPerPage, MAX_ITEM_SIZE);
	}
}