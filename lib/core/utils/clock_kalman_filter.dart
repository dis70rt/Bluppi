import 'package:bluppi/application/providers/party/sync_provider.dart';

class ClockKalmanFilter {
  double _theta;
  double _alpha;
  int _lastT1;

  double _p00 = 1000.0, _p01 = 0.0;
  double _p10 = 0.0, _p11 = 1.0;

  final double _r = 5000.0;
  final double _q00 = 0.1;
  final double _q11 = 1e-10;

  ClockKalmanFilter({required double initialOffset, required int initialTime})
      : _theta = initialOffset,
        _alpha = 1.0,
        _lastT1 = initialTime;

  ClockState update(double measuredOffset, int currentT1) {
    double dt = (currentT1 - _lastT1).toDouble();
    if (dt <= 0) dt = 1.0;

    double predictedTheta = _theta + (_alpha - 1.0) * dt;
    double predictedAlpha = _alpha;

    double p00Pred = _p00 + dt * (_p10 + _p01) + (dt * dt) * _p11 + _q00;
    double p01Pred = _p01 + dt * _p11;
    double p10Pred = _p10 + dt * _p11;
    double p11Pred = _p11 + _q11;

    double y = measuredOffset - predictedTheta;
    double s = p00Pred + _r;
    double k0 = p00Pred / s;
    double k1 = p10Pred / s;

    _theta = predictedTheta + (k0 * y);
    _alpha = predictedAlpha + (k1 * y);

    _p00 = (1.0 - k0) * p00Pred;
    _p01 = (1.0 - k0) * p01Pred;
    _p10 = p10Pred - (k1 * p00Pred);
    _p11 = p11Pred - (k1 * p01Pred);

    _lastT1 = currentT1;

    return ClockState(alpha: _alpha, thetaUs: _theta);
  }
}