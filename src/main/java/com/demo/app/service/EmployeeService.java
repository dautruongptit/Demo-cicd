package com.demo.app.service;

import com.demo.app.model.Employee;
import com.demo.app.repository.EmployeeRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
public class EmployeeService {

    private final EmployeeRepository employeeRepository;

    public List<Employee> getAll() {
        log.info("Fetching all employees");
        return employeeRepository.findAll();
    }

    public Employee getById(Long id) {
        return employeeRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Employee not found with id: " + id));
    }

    @Transactional
    public Employee create(Employee employee) {
        if (employeeRepository.existsByEmail(employee.getEmail())) {
            throw new RuntimeException("Email already exists: " + employee.getEmail());
        }
        log.info("Creating employee: {}", employee.getEmail());
        return employeeRepository.save(employee);
    }

    @Transactional
    public Employee update(Long id, Employee updated) {
        Employee existing = getById(id);
        existing.setName(updated.getName());
        existing.setDepartment(updated.getDepartment());
        existing.setSalary(updated.getSalary());
        log.info("Updating employee id: {}", id);
        return employeeRepository.save(existing);
    }

    @Transactional
    public void delete(Long id) {
        Employee existing = getById(id);
        log.info("Deleting employee id: {}", id);
        employeeRepository.delete(existing);
    }

    public List<Employee> getByDepartment(String department) {
        return employeeRepository.findByDepartmentIgnoreCase(department);
    }
}
