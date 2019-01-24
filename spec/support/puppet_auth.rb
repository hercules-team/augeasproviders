# frozen_string_literal: true

shared_examples_for 'puppet_auth resource' do
  it { is_expected.to have_puppet_auth_resource_count(1) }

  it do
    is_expected.to contain_puppet_auth('Deny /facts').only_with('name' => 'Deny /facts',
                                                                'ensure'        => 'present',
                                                                'path'          => '/facts',
                                                                'authenticated' => 'any',
                                                                'provider'      => 'augeas')
  end
end

shared_context 'puppet_auth' do
  it { is_expected.to have_puppet_auth_resource_count(0) }

  let :example_params do
    { 'Deny /facts' => { 'path' => '/facts', 'authenticated' => 'any' } }
  end

  context 'when puppet_auth_hash is a Hash' do
    let(:params) { { puppet_auth_hash: example_params } }
    let(:facts) { {} }

    include_examples 'puppet_auth resource'
  end

  context 'when ::augeasproviders_puppet_auth_hash is a Hash' do
    let(:params) { {} }
    let(:facts) { { augeasproviders_puppet_auth_hash: example_params } }

    include_examples 'puppet_auth resource'
  end
end
