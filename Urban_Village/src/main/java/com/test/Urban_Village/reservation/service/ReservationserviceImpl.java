package com.test.Urban_Village.reservation.service;

import java.sql.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.test.Urban_Village.member.dao.MemberDAO;
import com.test.Urban_Village.member.dao.MemberDAOImpl;
import com.test.Urban_Village.member.dto.MemberDTO;
import com.test.Urban_Village.reservation.dto.PayDTO;
import com.test.Urban_Village.reservation.dao.ReservationDAO;

@Service
public class ReservationserviceImpl implements ReservationService {
		@Autowired
		ReservationDAO dao;
		
		


		@Override
		public void addPay(PayDTO payDto) {
			// TODO Auto-generated method stub
			dao.addPay(payDto);
			
		}

		@Override
		public List<PayDTO> payList() {
			// TODO Auto-generated method stub
			return dao.payList();
		}

		@Override
		public List<PayDTO> reservationGetUserId(String loginId) {
			// TODO Auto-generated method stub
			return dao.reservationGetUserId(loginId);
		}
		
		@Override
		   public int delReservation(String reservation_id) {
		      // TODO Auto-generated method stub
		      return dao.delReservation(reservation_id);
		   }
		
	}
