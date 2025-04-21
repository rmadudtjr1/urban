package com.test.Urban_Village.reservation.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.test.Urban_Village.reservation.dao.ReservationDAO;
import com.test.Urban_Village.reservation.dto.PayDTO;

@Service
public class ReservationServiceImpl implements ReservationService {

    @Autowired
    ReservationDAO dao;

    @Override
    @Transactional
    public void addPay(PayDTO payDto) {
        dao.addPay(payDto);
    }

    @Override
    public List<PayDTO> payList() {
        return dao.payList();
    }

    @Override
    public List<PayDTO> reservationGetUserId(String loginId) {
        return dao.reservationGetUserId(loginId);
    }

   @Override
   public int delReservation(String reservation_id) {
      // TODO Auto-generated method stub
      return dao.delReservation(reservation_id);
   }
}