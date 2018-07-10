# enable windows 10 Hyper-V feature (availible only in Pro version)

Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All -NoRestartWrite-Output "Hyper-V enabled, to take it effect, restart system please."