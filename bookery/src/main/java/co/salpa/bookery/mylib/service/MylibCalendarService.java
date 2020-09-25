package co.salpa.bookery.mylib.service;

import org.springframework.ui.Model;

public interface MylibCalendarService {

	Model selectStudyService(int study_id, Model model);

}