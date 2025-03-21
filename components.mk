# Copyright 2023 Paranoid Android
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

ifneq (,$(filter all, $(TARGET_COMMON_QTI_COMPONENTS)))
TARGET_COMMON_QTI_COMPONENTS := \
    adreno \
    alarm \
    av \
    gps \
    init \
    overlay \
    telephony \
    usb \
    vibrator \
    wfd \
    wlan \
    $(filter-out all,$(TARGET_COMMON_QTI_COMPONENTS))
endif

# QTI Common Components

ifneq (,$(filter adreno, $(TARGET_COMMON_QTI_COMPONENTS)))
  ifeq ($(call is-board-platform-in-list,$(6_1_FAMILY)),true)
    TARGET_ADRENO_COMPONENT_VARIANT ?= adreno-u
  else ifeq ($(call is-board-platform-in-list,$(5_15_FAMILY)),true)
    TARGET_ADRENO_COMPONENT_VARIANT ?= adreno-t
  else ifeq ($(call is-board-platform-in-list,$(5_10_FAMILY)),true)
    TARGET_ADRENO_COMPONENT_VARIANT ?= adreno-s
  else ifeq ($(call is-board-platform-in-list,$(4_14_FAMILY) $(4_19_FAMILY) $(5_4_FAMILY)),true)
    TARGET_ADRENO_COMPONENT_VARIANT ?= adreno-r
  else ifeq ($(call is-board-platform-in-list,$(3_18_FAMILY) $(4_4_FAMILY) msm8953),true)
    TARGET_ADRENO_COMPONENT_VARIANT ?= adreno-5xx
  else
    $(error "Adreno component is enabled, but there is not a variant available for your platform.")
  endif
  include $(QCOM_COMMON_PATH)/vendor/$(TARGET_ADRENO_COMPONENT_VARIANT)/qti-$(TARGET_ADRENO_COMPONENT_VARIANT).mk
endif

ifneq (,$(filter alarm, $(TARGET_COMMON_QTI_COMPONENTS)))
  include $(QCOM_COMMON_PATH)/system/alarm/qti-alarm.mk
  include $(QCOM_COMMON_PATH)/vendor/alarm/qti-alarm.mk
endif

ifneq (,$(filter av, $(TARGET_COMMON_QTI_COMPONENTS)))
  include $(QCOM_COMMON_PATH)/system/av/qti-av.mk
endif

ifneq (,$(filter charging, $(TARGET_COMMON_QTI_COMPONENTS)))
  include $(QCOM_COMMON_PATH)/vendor/charging/qti-charging.mk
endif

ifneq (,$(filter dsprpcd, $(TARGET_COMMON_QTI_COMPONENTS)))
  include $(QCOM_COMMON_PATH)/vendor/dsprpcd/qti-dsprpcd.mk
endif

ifneq (,$(filter 5.10 5.15, $(TARGET_KERNEL_VERSION)))
  include $(QCOM_COMMON_PATH)/dlkm/qti-dlkm.mk
endif

ifneq (,$(filter gps, $(TARGET_COMMON_QTI_COMPONENTS)))
  include $(QCOM_COMMON_PATH)/system/gps/qti-gps.mk
  ifeq ($(call is-board-platform-in-list,$(5_10_FAMILY) $(5_15_FAMILY)),true)
    TARGET_GPS_COMPONENT_VARIANT ?= gps
  else
    TARGET_GPS_COMPONENT_VARIANT ?= gps-legacy
  endif
  include $(QCOM_COMMON_PATH)/vendor/$(TARGET_GPS_COMPONENT_VARIANT)/qti-$(TARGET_GPS_COMPONENT_VARIANT).mk
endif

ifneq (,$(filter init, $(TARGET_COMMON_QTI_COMPONENTS)))
  include $(QCOM_COMMON_PATH)/vendor/init/qti-init.mk
endif

ifneq (,$(filter keymaster, $(TARGET_COMMON_QTI_COMPONENTS)))
  include $(QCOM_COMMON_PATH)/vendor/keymaster/qti-keymaster.mk
endif

ifneq (,$(filter overlay, $(TARGET_COMMON_QTI_COMPONENTS)))
  include $(QCOM_COMMON_PATH)/system/overlay/qti-overlay.mk
  include $(QCOM_COMMON_PATH)/vendor/overlay/qti-overlay.mk
endif

ifneq (,$(filter qseecomd, $(TARGET_COMMON_QTI_COMPONENTS)))
  ifeq ($(call is-board-platform-in-list,$(5_4_FAMILY) $(5_10_FAMILY) $(5_15_FAMILY)),true)
    TARGET_QSEECOMD_COMPONENT_VARIANT ?= qseecomd
  else
    TARGET_QSEECOMD_COMPONENT_VARIANT ?= qseecomd-legacy
  endif
  include $(QCOM_COMMON_PATH)/vendor/$(TARGET_QSEECOMD_COMPONENT_VARIANT)/qti-$(TARGET_QSEECOMD_COMPONENT_VARIANT).mk
endif

ifneq (,$(filter telephony, $(TARGET_COMMON_QTI_COMPONENTS)))
  include $(QCOM_COMMON_PATH)/system/telephony/qti-telephony.mk
  include $(QCOM_COMMON_PATH)/vendor/telephony/qti-telephony.mk
endif

ifneq (,$(filter usb, $(TARGET_COMMON_QTI_COMPONENTS)))
  include $(QCOM_COMMON_PATH)/vendor/usb/qti-usb.mk
endif

ifneq (,$(filter vibrator, $(TARGET_COMMON_QTI_COMPONENTS)))
  include $(QCOM_COMMON_PATH)/vendor/vibrator/qti-vibrator.mk
endif

ifneq (,$(filter wfd, $(TARGET_COMMON_QTI_COMPONENTS)))
  include $(QCOM_COMMON_PATH)/system/wfd/qti-wfd.mk
endif

ifneq (,$(filter wlan, $(TARGET_COMMON_QTI_COMPONENTS)))
  ifeq ($(call is-board-platform-in-list,$(5_10_FAMILY) $(5_15_FAMILY)),true)
    TARGET_WLAN_COMPONENT_VARIANT ?= wlan
  else
    TARGET_WLAN_COMPONENT_VARIANT ?= wlan-legacy
  endif
  include $(QCOM_COMMON_PATH)/vendor/$(TARGET_WLAN_COMPONENT_VARIANT)/qti-$(TARGET_WLAN_COMPONENT_VARIANT).mk
endif
