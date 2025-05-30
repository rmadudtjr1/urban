package com.test.Urban_Village.reservation.service;

import java.util.List;

import com.test.Urban_Village.reservation.dto.PayDTO;


public interface ReservationService {
   
   public void addPay(PayDTO payDto);
   public List<PayDTO> payList();
   public List<PayDTO> reservationGetUserId(String loginId);
   public int delReservation(String reservation_id);
}