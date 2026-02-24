# Adaptive LQR – Quanser Qube Servo-2

This folder contains the adaptive LQR implementation for the Quanser Qube Servo-2 rotary inverted pendulum system.

The main Simulink file provided in this folder is:

AdaptiveQ_Function.slx

All adaptive logic and controller components are implemented inside a main subsystem named:

Adaptive LQR

---

## System Overview

The **Adaptive LQR** subsystem receives:

Inputs:
- x   → system state vector  
        x = [theta; alpha; theta_dot; alpha_dot]
- ref → reference position (theta reference)
- e   → tracking error (ref − theta)

Output:
- u   → control voltage applied to the system

---

## Subsystem Structure

Inside the *Adaptive LQR* subsystem, the following MATLAB Function blocks are implemented:

1. AdaptiveQ_QUBE_Simulink  
2. Riccati_LQR_Continuous  
3. AdaptiveLQRControl  

The adaptive mechanism modifies the Q matrix online and solves the continuous-time Riccati differential equation dynamically.

---

# 1️⃣ AdaptiveQ_QUBE_Simulink

This function performs adaptive scaling of the Q matrix based on:

- Position error magnitude
- Angular velocity
- Soft integral of tracking error
- Reference rate change
- Sliding-mode modulation

### Key Features

• Persistent integral state for smooth adaptation  
• Filtered angular velocity  
• Nonlinear scaling of Q(1,1)  
• Sliding-mode-inspired modulation term  
• Hard clamping to prevent instability  

### Adaptive Contributions

The adaptive Q(1,1) term is composed of:

- Position urgency term  
- Velocity urgency term  
- Integral bias removal term  
- Reference rate contribution  
- Sliding layer modulation  

The updated Q matrix is bounded to avoid excessive aggressiveness.

---

# 2️⃣ Riccati_LQR_Continuous

This block integrates the **continuous-time Riccati differential equation**:

Ṗ = AᵀP + PA − PBR⁻¹BᵀP + Q

Features:

• Online Riccati integration  
• Gain scaling factor (RC_a)  
• Optional convergence acceleration (gamma)  
• Numerical clamping for robustness  
• Gain saturation to prevent excessive control effort  

The block outputs:

- Pdot_vec → vectorized Riccati derivative  
- K_out    → adaptive LQR gain  

---

# 3️⃣ AdaptiveLQRControl

This function computes the final control signal:

u = K (x_ref − x)

Where:

x_ref = [ref 0 0 0]'

The control signal is voltage-limited:

-5V ≤ u ≤ 5V

---

## Adaptive Strategy Summary

The controller differs from classical LQR in that:

• The Q matrix is adapted online  
• The Riccati equation is solved continuously  
• Sliding-mode inspired modulation improves transient response  
• Error-dependent weighting increases control urgency during large deviations  
• Smooth filtering avoids high-frequency oscillations  

---

## Reproducibility Notes

The system matrices A and B correspond to the official Quanser Qube Servo-2 model.

Due to copyright restrictions, the original Quanser Simulink files are not included in this repository. Users must obtain the official Qube Servo-2 software package from Quanser.

The adaptive controller operates on top of the standard model provided by Quanser.

---

## Intended Contribution

This implementation demonstrates:

- Online adaptive LQR
- Error-sensitive Q tuning
- Continuous Riccati integration
- Hybrid sliding–LQR behavior

This folder contains the full adaptive logic inside a single Simulink file for clarity and reproducibility.

---

## Citation

If you use this work in your research, please cite the associated paper.  
Citation details will be provided upon publication.

```bibtex
@article{TBD,
  title   = {Real-time Adaptive Linear Quadratic Regulator Control for the QUBE--2 Rotary Inverted Pendulum},
  author  = {TBD},
  journal = {TBD},
  year    = {TBD}
}
