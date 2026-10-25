
package com.court.dao;

import com.court.entity.Case;
import com.court.utility.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CaseDAO {

    public boolean createCase(Case courtCase) {

        String sql = "insert into cases(case_number, title, description, case_type,status, litigant_id, lawyer_id, filing_date)values(?, ?, ?, ?, ?, ?, ?, ?) ";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setString(1, courtCase.getCaseNumber());
            statement.setString(2, courtCase.getTitle());
            statement.setString(3, courtCase.getDescription());
            statement.setString(4, courtCase.getCaseType());
            statement.setString(5, courtCase.getStatus());
            statement.setInt(6, courtCase.getLitigantId());

            if (courtCase.getLawyerId() > 0) {
                statement.setInt(7, courtCase.getLawyerId());
            } else {
                statement.setNull(7, java.sql.Types.INTEGER);
            }

            if (courtCase.getFilingDate() != null) {
                statement.setDate(8, courtCase.getFilingDate());
            } else {
                statement.setDate(8,
                        new java.sql.Date(System.currentTimeMillis()));
            }

            return statement.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Case> getCasesByLitigant(int litigantId) {

        List<Case> cases = new ArrayList<>();

        String sql = """
            SELECT * FROM cases
            WHERE litigant_id = ?
            ORDER BY filing_date DESC
            """;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, litigantId);

            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    cases.add(mapCase(resultSet));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return cases;
    }

    public List<Case> getCasesByLawyer(int lawyerId) {

        List<Case> cases = new ArrayList<>();

        String sql = """
            SELECT * FROM cases
            WHERE lawyer_id = ?
            ORDER BY filing_date DESC
            """;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, lawyerId);

            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    cases.add(mapCase(resultSet));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return cases;
    }

    private Case mapCase(ResultSet resultSet) throws SQLException {

        Case courtCase = new Case();

        courtCase.setId(resultSet.getInt("id"));
        courtCase.setCaseNumber(resultSet.getString("case_number"));
        courtCase.setTitle(resultSet.getString("title"));
        courtCase.setDescription(resultSet.getString("description"));
        courtCase.setCaseType(resultSet.getString("case_type"));
        courtCase.setStatus(resultSet.getString("status"));
        courtCase.setLitigantId(resultSet.getInt("litigant_id"));

        int lawyerId = resultSet.getInt("lawyer_id");
        courtCase.setLawyerId(
                resultSet.wasNull() ? 0 : lawyerId);

        courtCase.setFilingDate(resultSet.getDate("filing_date"));

        return courtCase;
    }


    public List<Case> getAllCases() {

        List<Case> cases = new ArrayList<>();

        String sql = """
        SELECT * FROM cases
        ORDER BY filing_date DESC
        """;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {
                cases.add(mapCase(resultSet));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return cases;
    }

    public boolean assignLawyer(int caseId, int lawyerId) {

        String sql = """
        UPDATE cases
        SET lawyer_id = ?
        WHERE id = ?
        """;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, lawyerId);
            statement.setInt(2, caseId);

            return statement.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }


}
