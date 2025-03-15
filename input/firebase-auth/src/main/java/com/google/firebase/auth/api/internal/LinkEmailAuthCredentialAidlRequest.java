/*
 * SPDX-FileCopyrightText: 2020, microG Project Team
 * SPDX-License-Identifier: Apache-2.0
 */

package com.google.firebase.auth.api.internal;

import org.microg.safeparcel.AutoSafeParcelable;

public class LinkEmailAuthCredentialAidlRequest extends AutoSafeParcelable {
    @Field(1)
    public String email;
    @Field(2)
    public String password;
    @Field(3)
    public String cachedState;
    public static final Creator<LinkEmailAuthCredentialAidlRequest> CREATOR = new AutoCreator<>(LinkEmailAuthCredentialAidlRequest.class);
}
