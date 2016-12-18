  // Log-priors for coefficients
       if (prior_dist == 1) target += normal_lpdf(z_beta | 0, 1);
  else if (prior_dist == 2) target += normal_lpdf(z_beta | 0, 1); // Student t
  else if (prior_dist == 3) { // hs
    target += normal_lpdf(z_beta | 0, 1);
    target += normal_lpdf(local[1] | 0, 1);
    target += inv_gamma_lpdf(local[2] | 0.5 * prior_df, 0.5 * prior_df);
    target += normal_lpdf(global[1] | 0, 1);
    target += inv_gamma_lpdf(global[2] | 0.5, 0.5);
  }
  else if (prior_dist == 4) { // hs+
    target += normal_lpdf(z_beta | 0, 1);
    target += normal_lpdf(local[1] | 0, 1);
    target += inv_gamma_lpdf(local[2] | 0.5 * prior_df, 0.5 * prior_df);
    target += normal_lpdf(local[3] | 0, 1);
    // unorthodox useage of prior_scale as another df hyperparameter
    target += inv_gamma_lpdf(local[4] | 0.5 * prior_scale, 0.5 * prior_scale);
    target += normal_lpdf(global[1] | 0, 1);
    target += inv_gamma_lpdf(global[2] | 0.5, 0.5);
  }
  /* else prior_dist is 0 and nothing is added */
  
  // Log-prior for intercept  
  if (has_intercept == 1) {
    if (prior_dist_for_intercept == 1)  // normal
      target += normal_lpdf(gamma | prior_mean_for_intercept, prior_scale_for_intercept);
    else if (prior_dist_for_intercept == 2)  // student_t
      target += student_t_lpdf(gamma | prior_df_for_intercept, prior_mean_for_intercept, 
                               prior_scale_for_intercept);
    /* else prior_dist is 0 and nothing is added */
  }
