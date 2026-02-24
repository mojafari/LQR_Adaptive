# LQR Control – Quanser Qube Servo-2

This folder contains the implementation of a standard Linear Quadratic Regulator (LQR) controller for the Quanser Qube Servo-2 rotary inverted pendulum system.

## Important Notice

⚠️ The Simulink models used in this implementation are part of the official Quanser Qube Servo-2 software package.

Due to copyright restrictions, the original Quanser Simulink files are **not included** in this repository.

To reproduce the results, users must obtain the official example models directly from Quanser and follow the standard LQR example provided with the Qube Servo-2 system.

## How to Reproduce the Results

1. Open the official Quanser Qube Servo-2 Simulink example for LQR control.
2. Use the system parameters provided by Quanser.
3. Replace the LQR weighting matrices (Q, R) or the gain matrix (K) with the values provided below.
4. Run the simulation under the same conditions described in the reference paper (if applicable).

## LQR Design Parameters

The controller was designed using the standard state-space formulation:

ẋ = Ax + Bu  
u = -Kx  

### Weighting Matrices

```matlab
Q = diag([q1, q2, q3, q4]);
R = r;

```
