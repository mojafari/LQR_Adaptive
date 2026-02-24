# LQR Control – Quanser Qube Servo-2

This folder contains the implementation of a standard Linear Quadratic Regulator (LQR) controller for the Quanser Qube Servo-2 rotary inverted pendulum system.

## Important Notice

⚠️ The Simulink models used in this implementation are part of the official Quanser Qube Servo-2 software package.

Due to copyright restrictions, the original Quanser Simulink files are **not included** in this repository.

To reproduce the results, users must obtain the official example models directly from Quanser and follow the standard LQR Control example provided with the Qube Servo-2 system.

## How to Reproduce the Results

1. Open the official Quanser Qube Servo-2 Simulink example for LQR Control.
2. Use the system parameters provided by Quanser.
3. Replace the LQR weighting matrices (Q, R) or the gain matrix (K) with the values provided below.

### Weighting Matrices

```matlab
Q = diag([5, 1, 1, 5]);
R = 1;
```

### Resulting Gain Matrix

```matlab
Q = [-2.2361,   43.9749,   -1.7938,    4.3719];
```

---

For additional details about the hardware platform and official examples, please refer to the documentation provided by Quanser.

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
