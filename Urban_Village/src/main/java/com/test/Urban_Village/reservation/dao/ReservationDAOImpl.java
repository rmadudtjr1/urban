package com.test.Urban_Village.reservation.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.test.Urban_Village.reservation.dto.PayDTO;


@Repository
public class ReservationDAOImpl implements ReservationDAO {

    @Autowired
    SqlSession sqlSession;

    @Override
    public void addPay(PayDTO payDto) {
        sqlSession.insert("mapper.reservation.addPay", payDto);
    }

    @Override
    public List<PayDTO> payList() {
        return sqlSession.selectList("mapper.reservation.payList");
    }

    @Override
    public List<PayDTO> reservationGetUserId(String loginId) {
        return sqlSession.selectList("mapper.reservation.reservationGetUserId", loginId);
    }

   @Override
   public int delReservation(String reservation_id) {
      // TODO Auto-generated method stub
      return sqlSession.delete("mapper.reservation.delReservation", reservation_id);
   }
}